defmodule Core.Content.Tag do
  @moduledoc false
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
    field :slug, Core.Slugs.Name.Type

    timestamps()
  end

  @doc false
  @spec changeset(Core.Content.Tag.t(), map) ::
          Ecto.Changeset.t(Core.Content.Tag.t())
  def changeset(record, attributes) do
    record
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> Core.Slugs.Name.maybe_generate_slug()
    |> Core.Slugs.Name.unique_constraint()
    |> unique_constraint(:name)
  end
end
