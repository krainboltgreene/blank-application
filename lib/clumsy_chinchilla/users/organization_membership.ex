defmodule ClumsyChinchilla.Users.OrganizationMembership do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization_memberships" do
    belongs_to(:organization, ClumsyChinchilla.Users.Organization, primary_key: true)
    belongs_to(:account, ClumsyChinchilla.Users.Account, primary_key: true)
    has_many(:organization_permissions, ClumsyChinchilla.Users.OrganizationPermission)
    has_many(:permissions, through: [:organization_permissions, :permission])

    timestamps()
  end

  @type t :: %__MODULE__{}

  @spec changeset(ClumsyChinchilla.Users.OrganizationMembership.t(), map) ::
          Ecto.Changeset.t(ClumsyChinchilla.Users.OrganizationMembership.t())
  def changeset(record, attributes) do
    record
    |> cast(attributes, [])
    |> validate_required([])
    |> put_assoc(:account, attributes.account)
    |> put_assoc(:organization, attributes.organization)
    |> assoc_constraint(:account)
    |> assoc_constraint(:organization)
  end
end
