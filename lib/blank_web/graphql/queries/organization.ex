defmodule BlankWeb.Graphql.Queries.Organization do
  use Absinthe.Schema.Notation

  object :organization_queries do
    @desc "Get all organizations"
    field :organizations, list_of(:organization) do
      middleware(&BlankWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&BlankWeb.Graphql.Resolvers.Organizations.list/3)
    end

    @desc "Get an organization by id"
    field :organization, :organization do
      arg(:id, non_null(:id))

      middleware(&BlankWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&BlankWeb.Graphql.Resolvers.Organizations.find/3)
    end
  end
end
