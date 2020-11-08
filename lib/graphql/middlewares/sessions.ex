defmodule Graphql.Middlewares.Sessions do
  @moduledoc false
  @spec update_session_id(%{value: %{id: String.t() | nil}}, any) :: map()
  def update_session_id(%{value: %{id: id}} = resolution, _) do
    Map.merge(resolution, %{
      context: Map.merge(resolution.context, %{cookies: [[:session_id, id]]})
    })
  end

  def update_session_id(resolution, _), do: resolution

  @spec absinthe_before_send(Plug.Conn.t(), Absinthe.Blueprint.t()) :: Plug.Conn.t()
  def absinthe_before_send(
        %Plug.Conn{method: "POST", request_path: "/graphql"} = connection,
        %Absinthe.Blueprint{execution: %{context: %{cookies: cookies}}}
      ) do
    Enum.reduce(cookies || [], connection, fn
      ([key, nil], accumulation) -> Plug.Conn.delete_session(accumulation, key)
      ([key, value], accumulation) -> Plug.Conn.put_session(accumulation, key, value)
    end)
  end
  def absinthe_before_send(connection, _), do: connection
end
