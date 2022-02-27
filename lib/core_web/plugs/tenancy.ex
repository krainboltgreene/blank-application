defmodule CoreWeb.Plugs.Tenancy do
  @moduledoc """
  This plug intercepts requests with the world id and makes sure we've switch to the world.
  """
  import Plug.Conn

  def init(_), do: nil

  def call(%Plug.Conn{assigns: %{world_id: world_id}} = conn, _) when is_bitstring(world_id) do
    Core.Repo.put_world_id(world_id)
    conn
  end

  def call(conn, _) do
    conn
    |> get_session("world_id")
    |> case do
      world_id when is_bitstring(world_id) ->
        Core.Repo.put_world_id(world_id)
        assign(conn, :world_id, world_id)

      _ ->
        assign(conn, :world_id, nil)
    end
  end
end
