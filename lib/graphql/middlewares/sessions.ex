defmodule Graphql.Middlewares.Sessions do
  @moduledoc false
  @spec update_session_id(%{value: %{id: String.t() | nil}}, any) :: map()
  def update_session_id(%{value: %{id: id}} = resolution, _) do
    Map.merge(resolution, %{
      context: Map.merge(resolution.context, %{cookies: [[:session_id, id]]})
    })
  end

  def update_session_id(resolution, _), do: resolution
end
