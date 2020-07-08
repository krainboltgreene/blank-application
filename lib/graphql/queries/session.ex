defmodule Graphql.Queries.Session do
  use Absinthe.Schema.Notation

  object :session_queries do
    @desc "Get current session"
    field :session, :session do

      resolve(&Graphql.Resolvers.Sessions.find/3)
    end
  end
end
