defmodule Graphql.Types.Organization do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :organization do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)

    field :accounts, list_of(non_null(:account)), resolve: dataloader(Database.Models.Account)

    field :organization_permissions, list_of(non_null(:organization_permission)),
      resolve: dataloader(Database.Models.OrganizationPermission)

    field :permissions, list_of(non_null(:permission)),
      resolve: dataloader(Database.Models.Permission)
  end
end
