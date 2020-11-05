defmodule Database.Models.OrganizationMembership do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization_memberships" do
    belongs_to(:organization, Database.Models.Organization, primary_key: true)
    belongs_to(:account, Database.Models.Account, primary_key: true)
    has_many(:organization_permissions, Database.Models.OrganizationPermission)

    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid
          | %{
              :account => any,
              :organization => any,
              optional(:__struct__) => none,
              optional(atom | binary) => any
            }
        ) :: Ecto.Changeset.t()
  @doc false
  @type t :: %__MODULE__{
    organization_id: Ecto.UUID.t(),
    organization: Database.Models.Organization.t(),
    account_id: Ecto.UUID.t(),
    account: Database.Models.Account.t(),
  }

  def changeset(record, attributes) do
    record
    |> cast(attributes, [])
    |> validate_required([])
    |> assoc_constraint(:account)
    |> assoc_constraint(:organization)
    |> put_assoc(:account, attributes.account)
    |> put_assoc(:organization, attributes.organization)
  end
end
