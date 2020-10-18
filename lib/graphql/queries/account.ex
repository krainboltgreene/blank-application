defmodule Graphql.Queries.Account do
  use Absinthe.Schema.Notation

  object :account_queries do
    import Graphql.Queries, only: :macros
    listable(:account, Graphql.Resolvers.Accounts)
    findable(:account, Graphql.Resolvers.Accounts)
  end
end
