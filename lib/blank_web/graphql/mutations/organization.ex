defmodule BlankWeb.Graphql.Mutations.Organization do
  use Absinthe.Schema.Notation

  object :organization_mutations do
    @desc "Create a new organization"
    field :create_organization, :organization do
      # arg :example, :type
      middleware(&BlankWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&BlankWeb.Graphql.Resolvers.Organizations.create/3)
    end

    @desc "Update an existing organization"
    field :update_organization, :organization do
      arg(:input, non_null(:id))

      # arg :example, :type

      middleware(&BlankWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&BlankWeb.Graphql.Resolvers.Organizations.update/3)
    end

    @desc "Permanently delete an existing organization"
    field :destroy_organization, :organization do
      arg(:input, non_null(:id))

      middleware(&BlankWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&BlankWeb.Graphql.Resolvers.Organizations.destroy/3)
    end
  end
end
