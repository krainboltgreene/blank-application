defmodule Graphql.Types.OrganizationPermission do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :organization_permission do
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)

    field :permission, non_null(:permission), resolve: dataloader(Database.Models.Permission)

    field :organization, non_null(:organization),
      resolve: dataloader(Database.Models.Organization)
  end
end
