defmodule Database.Models.OrganizationMembership do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models, only: :macros

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organization_memberships" do
    belongs_to(:organization, Database.Models.Organization, primary_key: true)
    belongs_to(:account, Database.Models.Account, primary_key: true)
    has_many(:organization_permissions, Database.Models.OrganizationPermission)
    has_many(:permissions, through: [:organization_permissions, :permission])

    timestamps()
  end

  @type t :: %__MODULE__{}

  has_standard_behavior()

  @spec changeset(Database.Models.OrganizationMembership.t(), map) ::
          Ecto.Changeset.t(Database.Models.OrganizationMembership.t())
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
