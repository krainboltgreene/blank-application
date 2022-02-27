defmodule Core.Users.OrganizationPermission do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          organization_membership:
            Core.Users.OrganizationMembership.t() | Ecto.Association.NotLoaded.t(),
          permission: Core.Users.Permission.t() | Ecto.Association.NotLoaded.t()
        }
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization_permissions" do
    belongs_to(:organization_membership, Core.Users.OrganizationMembership, primary_key: true)

    belongs_to(:permission, Core.Users.Permission, primary_key: true)
    has_one(:account, through: [:organization_membership, :account])
    has_one(:organization, through: [:organization_membership, :organization])

    timestamps()
  end

  @spec changeset(Core.Users.OrganizationPermission.t(), map) ::
          Ecto.Changeset.t(Core.Users.OrganizationPermission.t())
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
