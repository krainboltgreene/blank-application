defmodule HenosisWeb.Plugs.GraphqlSessionContext do
  @moduledoc """
  Allows us to identify the user by session data.
  """
  @behaviour Plug

  @spec init(any) :: atom() | binary() | [any()] | number() | tuple() | MapSet.t() | map()
  def init(opts), do: opts

  @spec call(any, any) :: Plug.Conn.t()
  def call(%Plug.Conn{method: "POST"} = connection, _) do
    session_id = Plug.Conn.get_session(connection, :session_id)

    account =
      if session_id do
        Database.Repo.get(Database.Models.Account, session_id)
      end

    Absinthe.Plug.put_options(
      connection,
      context: %{
        current_account: account
      }
    )
  end

  def call(connection, _), do: connection
end
