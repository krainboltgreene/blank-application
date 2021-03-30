defmodule Database.Models.Skinline do
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models, only: :macros

  @type t() :: %__MODULE__{
    id: nil | String.t,
    external_id: String.t,
    name: String.t,
    universe_id: nil | String.t(),
    universe: Database.Model.Universe.t()
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "skinlines" do
    field :external_id, :integer
    field :name, :string
    field :community_data, :map
    field :league_data, :map
    belongs_to :universe, Database.Models.Universe
    has_many :skins, Database.Models.Skin

    timestamps()
  end

  has_standard_behavior()

  @doc false
  def changeset(skinline, attrs) do
    skinline
    |> cast(attrs, [:external_id, :name, :community_data, :league_data])
    |> validate_required([:external_id, :name])
  end
end
