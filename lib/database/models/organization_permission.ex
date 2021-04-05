defmodule Database.Models.OrganizationPermission do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models, only: :macros

  @type t :: %__MODULE__{
    organization_membership: Database.Models.OrganizationMembership.t(),
    permission: Database.Models.Permission.t(),
  }
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization_permissions" do
    belongs_to(:organization_membership, Database.Models.OrganizationMembership, primary_key: true)

    belongs_to(:permission, Database.Models.Permission, primary_key: true)
    has_one(:account, through: [:organization_membership, :account])
    has_one(:organization, through: [:organization_membership, :organization])

    timestamps()
  end

  has_standard_behavior()

  @spec changeset(Database.Models.OrganizationPermission.t(), map) ::
          Ecto.Changeset.t(Database.Models.OrganizationPermission.t())
  def changeset(record, attributes) do
    record
    |> cast(attributes, [])
    |> validate_required([])
    |> put_assoc(:organization_membership, attributes.organization_membership)
    |> put_assoc(:permission, attributes.permission)
    |> assoc_constraint(:organization_membership)
    |> assoc_constraint(:permission)
  end
end
