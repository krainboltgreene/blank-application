defmodule Database.Models.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :name, :string
    field :slug, Database.Slugs.Name.Type

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    tag
      |> cast(attributes, [:name])
      |> validate_required([:name])
      |> Database.Slugs.Name.maybe_generate_slug
      |> Database.Slugs.Name.unique_constraint
      |> unique_constraint(:name)
  end
end
