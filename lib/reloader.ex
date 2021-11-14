defmodule Reloader do
  @moduledoc """
  Router for live-reload detection in development.
  ## Usage
  Add the `Phoenix.LiveReloader` plug within a `code_reloading?` block
  in your Endpoint, ie:
      if code_reloading? do
        socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
        plug Phoenix.CodeReloader
        plug Phoenix.LiveReloader
      end
  ## Configuration
  All live-reloading configuration must be done inside the `:live_reload`
  key of your endpoint, such as this:
      config :my_app, MyApp.Endpoint,
        ...
        live_reload: [
          patterns: [
            ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
            ~r{lib/my_app_web/views/.*(ex)$},
            ~r{lib/my_app_web/templates/.*(eex)$}
          ]
        ]
  The following options are supported:
    * `:patterns` - a list of patterns to trigger the live reloading.
      This option is required to enable any live reloading.
    * `:debounce` - an integer in milliseconds to wait before sending
      live reload events to the browser. Defaults to `0`.
    * `:iframe_attrs` - attrs to be given to the iframe injected by
      live reload. Expects a keyword list of atom keys and string values.
    * `:target_window` - the window that will be reloaded, as an atom.
      Valid values are `:top` and `:parent`. An invalid value will
      default to `:top`.
    * `:url` - the URL of the live reload socket connection. By default
      it will use the browser's host and port.
    * `:suffix` - if you are running live-reloading on an umbrella app,
      you may want to give a different suffix to each socket connection.
      You can do so with the `:suffix` option:
          live_reload: [
            suffix: "/proxied/app/path"
          ]
      And then configure the endpoint to use the same suffix:
          if code_reloading? do
            socket "/phoenix/live_reload/socket/proxied/app/path", Phoenix.LiveReloader.Socket
            ...
          end
  """

  import Plug.Conn
  @behaviour Plug

  def init(opts) do
    opts
  end

  def call(conn, _) do
    endpoint = conn.private.phoenix_endpoint
    config = endpoint.config(:live_reload)
    patterns = config[:patterns]

    if patterns && patterns != [] do
      before_send_inject_reloader(conn, endpoint, config)
    else
      conn
    end
  end

  defp before_send_inject_reloader(conn, endpoint, config) do
    register_before_send(conn, fn conn ->
      if conn.resp_body != nil and html?(conn) do
        resp_body = IO.iodata_to_binary(conn.resp_body)

        if has_body?(resp_body) and :code.is_loaded(endpoint) do
          [page | rest] = String.split(resp_body, "</body>")
          body = [page, inject_reload_sript(conn, endpoint, config), "</body>" | rest]
          put_in(conn.resp_body, body)
        else
          conn
        end
      else
        conn
      end
    end)
  end

  defp html?(conn) do
    case get_resp_header(conn, "content-type") do
      [] -> false
      [type | _] -> String.starts_with?(type, "text/html")
    end
  end

  defp has_body?(resp_body), do: String.contains?(resp_body, "<body")

  defp inject_reload_sript(_, _, _) do
    IO.iodata_to_binary(["""
    <script type="application/javascript">#{read_external_javascript(:phoenix, "priv/static/phoenix.js")}</script>
    <script type="application/javascript">
      var socket = new Phoenix.Socket("/phoenix/live_reload/socket");
      var interval = 100;
      var targetWindow = "top";
      #{read_external_javascript(:phoenix_live_reload, "priv/static/phoenix_live_reload.js")}
    </script>
    """])
  end

  defp read_external_javascript(application, file) do
    Application.app_dir(application, file)
      |> File.read!
      |> String.replace("//# sourceMappingURL=", "// ")
  end
end
