defmodule BlankWeb.Router do
  use BlankWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "http://localhost:9000"
    plug :accepts, ["json"]
    plug :fetch_session
    plug Blank.Plugs.GraphqlSessionContext
  end

  scope "/" do
    pipe_through :api

    forward "/", Absinthe.Plug,
      schema: BlankWeb.Graphql.Schema,
      before_send: {__MODULE__, :absinthe_before_send}
  end

  def absinthe_before_send(
        %Plug.Conn{method: "POST"} = connection,
        %Absinthe.Blueprint{} = blueprint
      ) do
    Enum.reduce(blueprint.execution.context[:cookies] || [], connection, fn [key, value],
                                                                            accumulation ->
      if value do
        Plug.Conn.put_session(accumulation, key, value)
      else
        Plug.Conn.delete_session(accumulation, key)
      end
    end)
  end

  def absinthe_before_send(connection, _), do: connection
end
