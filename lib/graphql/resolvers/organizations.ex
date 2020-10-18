defmodule Graphql.Resolvers.Organizations do
  import Graphql.Resolvers,
    only: :macros

  listable(Database.Models.Organization, :authenticated)
  findable(Database.Models.Organization, :authenticated)
  creatable(Database.Models.Organization, :authenticated)
  updatable(Database.Models.Organization, :authenticated)
  destroyable(Database.Models.Organization, :authenticated)
end
