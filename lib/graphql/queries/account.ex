defmodule Graphql.Queries.Account do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Graphql.Queries, only: :macros
  import Graphql.Resolvers, only: :macros

  object :account_queries do
    listable_field(:account)
    findable_field(:account)
  end

  listable(Database.Models.Account, :authenticated)
  findable(Database.Models.Account, :authenticated)
end
