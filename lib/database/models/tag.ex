defmodule Database.Models.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models, only: :macros


  @type t :: %__MODULE__{
    name: String.t(),
    slug: String.t()
  }
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :name, :string
    field :slug, Database.Slugs.Name.Type

    # many_to_many :menu_items, Database.Models.MenuItem, join_through: Database.Models.MenuItemTag

    timestamps()
  end

  has_standard_behavior()

  @doc false
  @spec changeset(Database.Models.Tag.t(), map) :: Ecto.Changeset.t(Database.Models.Tag.t())
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> Database.Slugs.Name.maybe_generate_slug()
    |> Database.Slugs.Name.unique_constraint()
    |> unique_constraint(:name)
  end
end
