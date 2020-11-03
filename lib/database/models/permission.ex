defmodule Database.Models.Permission do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "permissions" do
    field(:name, :string)
    field(:slug, Database.Slugs.Name.Type)
    has_many(:organization_permissions, Database.Models.OrganizationPermission)

    timestamps()
  end

  @spec data :: Dataloader.Ecto.t()
  def data() do
    Dataloader.Ecto.new(Database.Repository)
  end

  @spec changeset(map, map) :: Ecto.Changeset.t()
  @doc false
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> Database.Slugs.Name.maybe_generate_slug()
    |> Database.Slugs.Name.unique_constraint()
  end
end
