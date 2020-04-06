defmodule ExampleWeb.Graphql.Middlewares.Sessions do
  @spec update_session_id(%{id: bitstring}, any) :: map()
  def update_session_id(%{value: %{id: id}} = resolution, _) when is_bitstring(id) do
    Map.merge(resolution, %{
      context: Map.merge(resolution.context, %{cookies: [[:session_id, id]]})
    })
  end

  def update_session_id(resolution, _), do: resolution

  @spec require_authentication(map, any) :: {:error, bitstring}
  def require_authentication(%{current_account: nil} = resolution, _),
    do: resolution |> Absinthe.Resolution.put_result({:error, "unauthenticated"})

  def require_authentication(resolution, _), do: resolution
end
