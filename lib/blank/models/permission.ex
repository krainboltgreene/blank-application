defmodule Blank.Models.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "permissions" do
    field :name, :string
    field :slug, Blank.Slugs.Name.Type
    has_many :organization_permissions, Blank.Models.OrganizationPermission

    timestamps()
  end

  @doc false
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> Blank.Slugs.Name.maybe_generate_slug()
    |> Blank.Slugs.Name.unique_constraint()
  end
end
