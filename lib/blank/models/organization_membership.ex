defmodule Blank.Models.OrganizationMembership do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization_memberships" do
    belongs_to :organization, Blank.Models.Organization, primary_key: true
    belongs_to :account, Blank.Models.Account, primary_key: true
    has_many :organization_permissions, Blank.Models.OrganizationPermission

    timestamps()
  end

  @doc false
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
