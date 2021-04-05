defmodule Database.Models.Review do
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
  schema "reviews" do
    field :body, :string
    field :moderation_state, :string, default: "pending"
    belongs_to :author_account, Database.Models.Account, primary_key: true
    belongs_to :menu_item, Database.Models.MenuItem, primary_key: true
    many_to_many :tags, Database.Models.Tag, join_through: Database.Models.ReviewTag, on_replace: :delete
    has_many :critiques, Database.Models.Critique

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    record
      |> cast(attributes, [:body, :moderation_state])
      |> validate_required([:body, :moderation_state])
      |> foreign_key_constraint(:author_account_id)
  end
end
