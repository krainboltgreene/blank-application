defmodule Graphql.Types.OrganizationMembership do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :organization_membership do
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)

    field :account, non_null(:account),
      resolve: dataloader(Database.Models.Account)
    field :organization_permissions, list_of(non_null(:organization_permission)),
      resolve: dataloader(Database.Models.OrganizationPermission)
    field :organization, non_null(:organization),
      resolve: dataloader(Database.Models.Organization)
  end
end
