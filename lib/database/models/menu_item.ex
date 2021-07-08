defmodule Database.Models.MenuItem do
  use Ecto.Schema
  import Estate, only: [state_machines: 1]
  import Ecto.Changeset

  state_machines([
    moderation_state: [
      publish: [draft: "processing"],
      approve: [draft: "published"],
      reject: [draft: "rejected"],
      kill: [published: "killed"],
      archive: [published: "archived"]
    ]
  ])

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_items" do
    field :name, :string
    field :slug, Database.Slugs.Name.Type
    field :body, :string
    field :moderation_state, :string, default: "pending"
    belongs_to :establishment, Database.Models.Establishment, primary_key: true
    has_many :reviews, Database.Models.Review
    many_to_many :tags, Database.Models.Tag, join_through: Database.Models.MenuItemTag, on_replace: :delete
    many_to_many :allergies, Database.Models.Allergy, join_through: Database.Models.MenuItemAllergy, on_replace: :delete
    many_to_many :diets, Database.Models.Diet, join_through: Database.Models.MenuItemDiet, on_replace: :delete

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    record
      |> cast(attributes, [:name, :body, :moderation_state])
      |> validate_required([:name, :body, :moderation_state])
      |> Database.Slugs.Name.maybe_generate_slug
      |> Database.Slugs.Name.unique_constraint
      |> foreign_key_constraint(:establishment_id)
  end
end
