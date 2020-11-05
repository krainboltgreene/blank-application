defmodule Database.Models.Organization do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organizations" do
    field(:name, :string)
    field(:slug, Database.Slugs.Name.Type)
    has_many(:organization_memberships, Database.Models.OrganizationMembership)
    has_many(:accounts, through: [:organization_memberships, :account])

    timestamps()
  end

  @type t :: %__MODULE__{
    name: String.t(),
    slug: String.t()
  }

  @spec changeset(map, map) :: Ecto.Changeset.t()
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> Database.Slugs.Name.maybe_generate_slug()
    |> Database.Slugs.Name.unique_constraint()
  end
end
