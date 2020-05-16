defmodule HenosisWeb.Graphql.Mutations.Permission do
  use Absinthe.Schema.Notation

  input_object :new_permission do
    field :name, :string
  end

  input_object :permission_changeset do
    field :id, non_null(:id)
    field :name, :string
  end

  input_object :permission_identifier do
    field :id, non_null(:id)
  end

  object :permission_mutations do
    @desc "Create a new permission"
    field :create_permission, :permission do
      arg(:input, non_null(:new_permission))
      middleware(&HenosisWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&HenosisWeb.Graphql.Resolvers.Permissions.create/3)
    end

    @desc "Update an existing permission"
    field :update_permission, :permission do
      arg(:input, non_null(:permission_changeset))

      middleware(&HenosisWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&HenosisWeb.Graphql.Resolvers.Permissions.update/3)
    end

    @desc "Permanently delete an existing permission"
    field :destroy_permission, :permission do
      arg(:input, non_null(:permission_identifier))

      middleware(&HenosisWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&HenosisWeb.Graphql.Resolvers.Permissions.destroy/3)
    end
  end
end