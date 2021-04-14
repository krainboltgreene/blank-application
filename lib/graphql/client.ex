defmodule Graphql.Client do
  require Logger

  @spec request(binary, any) :: {:error, :client_timeout | :unknown | [any]} | {:ok, any}
  def request(body, variables) when is_bitstring(body) or (is_map(body) and is_map(variables)) do
    Logger.info("[Client] Making a request to self")
    started_at = Time.utc_now()

    Application.fetch_env!(:find_reel_love, :graphql)[:uri]
    |> Brains.Connection.new()
    |> Brains.query(body, variables: variables)
    |> Brains.Response.decode()
    |> resolution(name(body), Time.diff(Time.utc_now(), started_at, :millisecond))
  end

  def resolution({:ok, %{body: %{"errors" => errors}}}, name, _) do
    errors
    |> Enum.map(&Map.get(&1, "message"))
    |> Enum.map(&"[Client] [#{name}] #{&1}")
    |> Enum.each(&Logger.error/1)

    {:error, errors |> Enum.map(&Map.get(&1, "message"))}
  end

  def resolution({:ok, %{body: %{"data" => data}}}, name, duration) do
    Logger.info("[Client] [#{name}] Completed request to self (#{duration}ms)")
    {:ok, data}
  end

  def resolution({:error, :timeout}, name, duration) do
    Logger.error("[Client] [#{name}] Request to self timed out (#{duration}ms)")
    {:error, :client_timeout}
  end

  def resolution({_, response}, name, duration) do
    Logger.error("[Client] [#{name}] #{response |> Kernel.inspect()} (#{duration}ms)")
    {:error, :unknown}
  end

  defp name(query) do
    Regex.run(~r/(?:mutation|query) (\w+)/, query) |> List.first()
  end
end
