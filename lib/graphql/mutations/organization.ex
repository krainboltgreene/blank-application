defmodule Graphql.Mutations.Organization do
  use Absinthe.Schema.Notation

  input_object :new_organization do
    field :name, :string
  end

  input_object :organization_changeset do
    field :id, non_null(:id)
    field :name, :string
  end

  object :organization_mutations do
    @desc "Create a new organization"
    field :create_organization, :organization do
      arg(:input, non_null(:new_organization))

      resolve(&Graphql.Resolvers.Organizations.create/3)
    end

    @desc "Update an existing organization"
    field :update_organization, :organization do
      arg(:input, non_null(:organization_changeset))

      resolve(&Graphql.Resolvers.Organizations.update/3)
    end

    @desc "Permanently delete an existing organization"
    field :destroy_organization, :organization do
      arg(:input, non_null(:identity))

      resolve(&Graphql.Resolvers.Organizations.destroy/3)
    end
  end
end
