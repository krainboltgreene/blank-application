defmodule Database.Models.OrganizationPermission do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization_permissions" do
    belongs_to(:organization_membership, Database.Models.OrganizationMembership, primary_key: true)
    belongs_to(:permission, Database.Models.Permission, primary_key: true)
    has_one(:account, through: [:organization_membership, :account])
    has_one(:organization, through: [:organization_membership, :organization])

    timestamps()
  end

  @type t :: %__MODULE__{
  }

  @spec changeset(Database.Models.OrganizationPermission.t(), map) :: Ecto.Changeset.t(Database.Models.OrganizationPermission.t())
  def changeset(record, attributes) do
    record
    |> cast(attributes, [])
    |> validate_required([])
    |> put_assoc(:organization_membership, attributes.organization_membership)
    |> put_assoc(:permission, attributes.permission)
    |> assoc_constraint(:organization_membership)
    |> assoc_constraint(:permission)
  end

  @spec create(%{organization_membership: Database.Models.OrganizationMembership.t(), permission: Database.Models.Permission.t()}) :: {:ok, Database.Models.OrganizationPermission.t()} | {:error, Database.Models.OrganizationPermission.t() | Ecto.Changeset.t(Database.Models.OrganizationPermission.t())}
  def create(attributes) do
    Database.Models.OrganizationPermission.__struct__()
    |> changeset(attributes)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end
end
