defmodule Graphql.Mutations.Permission do
  @moduledoc false
  import Graphql.Resolvers, only: :macros
  use Absinthe.Schema.Notation

  input_object :new_permission do
    field :name, :string
  end

  input_object :permission_changeset do
    field :id, non_null(:id)
    field :name, :string
  end

  object :permission_mutations do
    @desc "Create a new permission"
    field :create_permission, :permission do
      arg(:input, non_null(:new_permission))
      resolve(&create/3)
    end

    @desc "Update an existing permission"
    field :update_permission, :permission do
      arg(:input, non_null(:permission_changeset))

      resolve(&update/3)
    end

    @desc "Permanently delete an existing permission"
    field :destroy_permission, :permission do
      arg(:input, non_null(:identity))

      resolve(&destroy/3)
    end
  end

  listable(Database.Models.Permission, :authenticated)
  findable(Database.Models.Permission, :authenticated)
  creatable(Database.Models.Permission, :authenticated)
  updatable(Database.Models.Permission, :authenticated)
  destroyable(Database.Models.Permission, :authenticated)
end
