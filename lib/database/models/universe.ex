defmodule Database.Models.Universe do
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models, only: :macros

  @type t() :: %__MODULE__{
    id: nil | String.t(),
    external_id: String.t(),
    name: String.t()
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "universes" do
    field :external_id, :integer
    field :name, :string
    field :community_data, :map
    field :league_data, :map
    has_many :skinlines, Database.Models.Skinline, on_replace: :nilify

    timestamps()
  end

  has_standard_behavior()

  @doc false
  def changeset(universe, attrs) do
    universe
    |> Database.Repository.preload(:skinlines)
    |> cast(attrs, [:external_id, :name, :community_data, :league_data])
    |> put_assoc(:skinlines, attrs.skinlines)
    |> validate_required([:external_id, :name])
  end
end
