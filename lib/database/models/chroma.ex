defmodule Database.Models.Chroma do
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models, only: :macros

  @type t() :: %__MODULE__{
    id: nil | String.t,
    external_id: String.t,
    name: String.t,
    colors: list(String.t),
    skin: nil | Database.Model.Universe.t()
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "chromas" do
    field :colors, {:array, :string}
    field :external_id, :integer
    field :name, :string
    field :community_data, :map
    field :league_data, :map
    belongs_to :skin, Database.Models.Skin

    timestamps()
  end

  has_standard_behavior()

  @doc false
  def changeset(chroma, attrs) do
    chroma
    |> cast(attrs, [:external_id, :name, :colors, :community_data, :league_data])
    |> validate_required([:external_id, :name, :colors])
  end
end
