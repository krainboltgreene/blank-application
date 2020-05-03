defmodule Henosis.Models.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "permissions" do
    field :name, :string
    field :slug, Henosis.Slugs.Name.Type
    has_many :organization_permissions, Henosis.Models.OrganizationPermission

    timestamps()
  end

  @spec changeset(map, map) :: Ecto.Changeset.t()
  @doc false
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> Henosis.Slugs.Name.maybe_generate_slug()
    |> Henosis.Slugs.Name.unique_constraint()
  end
end
