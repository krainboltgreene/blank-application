defmodule ClumsyChinchilla.Content.Tag do
  use Ecto.Schema
  import Ecto.Changeset


  @type t :: %__MODULE__{
    name: String.t() | nil,
    slug: String.t() | nil
  }
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :name, :string
    field :slug, ClumsyChinchilla.Slugs.Name.Type

    timestamps()
  end

  @doc false
  @spec changeset(ClumsyChinchilla.Content.Tag.t(), map) :: Ecto.Changeset.t(ClumsyChinchilla.Content.Tag.t())
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> ClumsyChinchilla.Slugs.Name.maybe_generate_slug()
    |> ClumsyChinchilla.Slugs.Name.unique_constraint()
    |> unique_constraint(:name)
  end
end
