defmodule Graphql.Queries.Permission do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Graphql.Queries, only: :macros
  import Graphql.Resolvers, only: :macros

  object :permission_queries do
    listable_field(:permission)
    findable_field(:permission)
  end

  listable(Database.Models.Permission, :authenticated)
  findable(Database.Models.Permission, :authenticated)
end
