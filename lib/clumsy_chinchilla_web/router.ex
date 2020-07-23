defmodule ClumsyChinchillaWeb.Router do
  use ClumsyChinchillaWeb, :router

  @spec absinthe_before_send(map, map) :: map
  def absinthe_before_send(
        %Plug.Conn{method: "POST"} = connection,
        %Absinthe.Blueprint{} = blueprint
      ) do
    Enum.reduce(blueprint.execution.context[:cookies] || [], connection, fn [key, value], accumulation ->
      if value do
        Plug.Conn.put_session(accumulation, key, value)
      else
        Plug.Conn.delete_session(accumulation, key)
      end
    end)
  end

  def absinthe_before_send(connection, _), do: connection

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ClumsyChinchillaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["http://localhost:8000", "http://localhost:8080"]
    plug :fetch_session
    plug HenosisWeb.Plugs.GraphqlSessionContext
  end

  scope "/", ClumsyChinchillaWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/" do
    pipe_through :api

    forward "/graphql",
      Absinthe.Plug,
      schema: Graphql.Schema,
      analyze_complexity: true,
      max_complexity: 200,
      before_send: {__MODULE__, :absinthe_before_send}
  end

  # Other scopes may use custom stacks.
  # scope "/api", ClumsyChinchillaWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ClumsyChinchillaWeb.Telemetry
    end
  end
end
