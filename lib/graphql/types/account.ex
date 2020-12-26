defmodule Graphql.Types.Account do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :account do
    field :id, non_null(:id)
    field :email_address, non_null(:string)
    field :name, :string
    field :username, :string
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)

    field :organization_memberships, list_of(non_null(:organization_membership)),
      resolve: dataloader(Database.Models.OrganizationMembership)

    field :organizations, list_of(:organization),
      resolve: dataloader(Database.Models.Organization)

    field :settings, non_null(:settings)
  end
end
