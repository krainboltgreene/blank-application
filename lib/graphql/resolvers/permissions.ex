defmodule Graphql.Resolvers.Permissions do
  import Graphql.Resolvers,
    only: :macros

  listable(Database.Models.Permission, :authenticated)
  findable(Database.Models.Permission, :authenticated)
  creatable(Database.Models.Permission, :authenticated)
  updatable(Database.Models.Permission, :authenticated)
  destroyable(Database.Models.Permission, :authenticated)
end
