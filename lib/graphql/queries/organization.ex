defmodule Graphql.Queries.Organization do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Graphql.Queries, only: :macros
  import Graphql.Resolvers, only: :macros

  object :organization_queries do
    listable_field(:organization)
    findable_field(:organization)
  end

  listable(Database.Models.Organization, :authenticated)
  findable(Database.Models.Organization, :authenticated)
end
