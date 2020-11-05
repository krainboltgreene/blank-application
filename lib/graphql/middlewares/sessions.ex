defmodule Graphql.Middlewares.Sessions do
  @moduledoc false
  @spec update_session_id(%{id: String.t}, any) :: map()
  def update_session_id(%{value: %{id: id}} = resolution, _) when is_bitstring(id) do
    Map.merge(resolution, %{
      context: Map.merge(resolution.context, %{cookies: [[:session_id, id]]})
    })
  end

  def update_session_id(resolution, _), do: resolution
end
