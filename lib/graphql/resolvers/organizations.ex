defmodule Graphql.Resolvers.Organizations do
  import Graphql.Resolvers,
    only: [listable: 2, findable: 2, creatable: 2, updatable: 2, destroyable: 2]

  listable(Database.Models.Organization, :authenticated)
  findable(Database.Models.Organization, :authenticated)
  creatable(Database.Models.Organization, :authenticated)
  updatable(Database.Models.Organization, :authenticated)
  destroyable(Database.Models.Organization, :authenticated)
end
