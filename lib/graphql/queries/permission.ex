defmodule Graphql.Queries.Permission do
  use Absinthe.Schema.Notation

  object :permission_queries do
    import Graphql.Queries, only: :macros
    listable(:permission, Graphql.Resolvers.Permissions)
    findable(:permission, Graphql.Resolvers.Permissions)
  end
end
