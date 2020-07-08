defmodule HenosisWeb.Plugs.GraphqlSessionContext do
  @behaviour Plug

  @spec init(any) :: any
  def init(opts), do: opts

  @spec call(any, any) :: any
  def call(%Plug.Conn{method: "POST"} = connection, _) do
    session_id = Plug.Conn.get_session(connection, :session_id)

    account = if session_id do
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
