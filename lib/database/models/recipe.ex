defmodule Database.Models.Recipe do
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
  schema "recipes" do
    field :name, :string
    field :slug, Database.Slugs.Name.Type
    field :body, :string
    field :cook_time, :integer
    field :ingredients, {:array, :string}
    field :instructions, {:array, :string}
    field :moderation_state, :string, default: "pending"
    field :prep_time, :integer
    belongs_to :author_account, Database.Models.Account
    many_to_many :tags, Database.Models.Tag, join_through: Database.Models.RecipeTag
    many_to_many :allergies, Database.Models.Allergy, join_through: Database.Models.MenuItemAllergy
    many_to_many :diets, Database.Models.Diet, join_through: Database.Models.MenuItemDiet

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    record
      |> cast(attributes, [:author_account_id, :moderation_state, :name, :body, :ingredients, :instructions, :cook_time, :prep_time])
      |> validate_required([:author_account_id, :moderation_state, :name, :body, :ingredients, :instructions, :cook_time, :prep_time])
      |> Database.Slugs.Name.maybe_generate_slug
      |> Database.Slugs.Name.unique_constraint
      |> assoc_constraint(:author_account)
      |> foreign_key_constraint(:author_account_id)
  end
end
