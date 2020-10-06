defmodule Graphql.Resolvers.Permissions do
  import Graphql.Resolvers, only: [listable: 2, findable: 2, creatable: 2, updatable: 2, destroyable: 2]

  listable(Database.Models.Permission, :authenticated)
  findable(Database.Models.Permission, :authenticated)
  creatable(Database.Models.Permission, :authenticated)
  updatable(Database.Models.Permission, :authenticated)
  destroyable(Database.Models.Permission, :authenticated)
end
