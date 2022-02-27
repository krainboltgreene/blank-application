defmodule Core.Users.Permission do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          name: String.t() | nil,
          slug: String.t() | nil
        }
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "permissions" do
    field(:name, :string)
    field(:slug, Core.Slugs.Name.Type)
    has_many(:organization_permissions, Core.Users.OrganizationPermission)

    timestamps()
  end

  @spec changeset(struct, map) :: Ecto.Changeset.t()
  @doc false
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> Core.Slugs.Name.maybe_generate_slug()
    |> Core.Slugs.Name.unique_constraint()
  end
end
