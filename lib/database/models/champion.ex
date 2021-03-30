defmodule Database.Models.Champion do
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models, only: :macros

  @type t() :: %__MODULE__{
    id: nil | String.t,
    external_id: String.t,
    name: String.t,
    skins: list(Database.Models.Skin.t())
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "champions" do
    field :external_id, :string
    field :name, :string
    field :community_data, :map
    field :league_data, :map
    has_many :skins, Database.Models.Skin

    timestamps()
  end

  has_standard_behavior()

  @doc false
  def changeset(champion, attrs) do
    champion
    |> Database.Repository.preload(:skins)
    |> cast(attrs, [:external_id, :name, :community_data, :league_data])
    |> put_assoc(:skins, attrs.skins)
    |> validate_required([:external_id, :name])
  end
end
