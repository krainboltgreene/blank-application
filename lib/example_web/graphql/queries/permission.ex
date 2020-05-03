defmodule ClumsyChinchillaWeb.Graphql.Queries.Permission do
  use Absinthe.Schema.Notation

  object :permission_queries do
    @desc "Get all permissions"
    field :permissions, list_of(:permission) do
      middleware(&ClumsyChinchillaWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&ClumsyChinchillaWeb.Graphql.Resolvers.Permissions.list/3)
    end

    @desc "Get an permission by id"
    field :permission, :permission do
      arg(:id, non_null(:id))

      middleware(&ClumsyChinchillaWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&ClumsyChinchillaWeb.Graphql.Resolvers.Permissions.find/3)
    end
  end
end
