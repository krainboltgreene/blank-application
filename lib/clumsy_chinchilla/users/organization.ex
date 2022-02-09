defmodule ClumsyChinchilla.Users.Organization do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          name: String.t(),
          slug: String.t()
        }
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organizations" do
    field(:name, :string)
    field(:slug, ClumsyChinchilla.Slugs.Name.Type)
    has_many(:organization_memberships, ClumsyChinchilla.Users.OrganizationMembership)
    has_many(:permissions, through: [:organization_memberships, :permissions])
    has_many(:accounts, through: [:organization_memberships, :account])

    timestamps()
  end

  @spec changeset(struct, map) :: Ecto.Changeset.t()
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> ClumsyChinchilla.Slugs.Name.maybe_generate_slug()
    |> ClumsyChinchilla.Slugs.Name.unique_constraint()
  end
end
