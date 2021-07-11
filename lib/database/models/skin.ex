defmodule Database.Models.Skin do
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models, only: :macros

  @loading_image_url "http://ddragon.leagueoflegends.com/cdn/img/champion/loading"

  @type t() :: %__MODULE__{
    id: nil | String.t,
    external_id: String.t,
    name: String.t,
    position: integer,
    skinline: nil | Database.Models.Skinline.t,
    champion: nil | Database.Models.Champion.t,
    chromas: list(Database.Models.Chroma.t)
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "skins" do
    # default: boolean from isBase
    field :external_id, :integer
    field :name, :string
    field :position, :integer
    field :community_data, :map
    field :league_data, :map
    belongs_to :skinline, Database.Models.Skinline
    belongs_to :champion, Database.Models.Champion
    has_many :chromas, Database.Models.Chroma, on_replace: :delete

    timestamps()
  end

  @spec loading_image_uri(__MODULE__.t) :: String.t
  def loading_image_uri(skin) do
    # skin_with_champion = skin |> Database.Repository.preload(:champion)

    "#{@loading_image_url}/#{skin.champion.id}_#{skin.position}.jpg"
  end

  has_standard_behavior()

  @doc false
  def changeset(skin, attrs) do
    skin
    |> Database.Repository.preload([:chromas, :skinline])
    |> cast(attrs, [:external_id, :name, :position, :community_data, :league_data])
    |> put_assoc(:chromas, attrs.chromas)
    |> put_assoc(:skinline, attrs.skinline)
    |> validate_required([:external_id, :name, :position])
    |> unique_constraint([:external_id, :position, :champion_id])
  end
end
