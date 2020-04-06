defmodule Example.Models.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organizations" do
    field :name, :string
    field :slug, Example.Slugs.Name.Type
    has_many :organization_memberships, Example.Models.OrganizationMembership
    has_many :accounts, through: [:organization_memberships, :account]

    timestamps()
  end

  @doc false
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> Example.Slugs.Name.maybe_generate_slug()
    |> Example.Slugs.Name.unique_constraint()
  end
end
