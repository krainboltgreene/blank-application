defmodule Graphql.Queries.Organization do
  use Absinthe.Schema.Notation

  object :organization_queries do
    import Graphql.Queries, only: [listable: 2, findable: 2]
    listable(:organization, Graphql.Resolvers.Organizations)
    findable(:organization, Graphql.Resolvers.Organizations)
  end
end
