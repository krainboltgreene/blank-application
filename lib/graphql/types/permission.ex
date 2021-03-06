defmodule Graphql.Types.Permission do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :permission do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)

    field :organization_permissions, list_of(non_null(:organization_permission)),
      resolve: dataloader(Database.Models.OrganizationPermission)
  end
end
