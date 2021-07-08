defmodule Database.Models.Allergy do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "allergies" do
    field :name, :string
    field :slug, Database.Slugs.Name.Type
    many_to_many :menu_items, Database.Models.MenuItem, join_through: Database.Models.MenuItemAllergy
    many_to_many :recipes, Database.Models.Recipe, join_through: Database.Models.RecipeDiet

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    record
      |> cast(attributes, [:name])
      |> validate_required([:name])
      |> Database.Slugs.Name.maybe_generate_slug
      |> Database.Slugs.Name.unique_constraint
      |> unique_constraint(:name)
  end
end
