defmodule Database.Models.Establishment do
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
  schema "establishments" do
    field :name, :string
    field :slug, Database.Slugs.Name.Type
    field :google_place_data, :map
    field :google_place_id, :string
    field :moderation_state, :string, default: "pending"
    has_many :menu_items, Database.Models.MenuItem
    many_to_many :payment_types, Database.Models.PaymentType, join_through: Database.Models.EstablishmentPaymentType, on_replace: :delete
    many_to_many :tags, Database.Models.Tag, join_through: Database.Models.EstablishmentTag, on_replace: :delete

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    establishment
      |> cast(attributes, [:name, :google_place_id, :google_place_data, :moderation_state])
      |> cast_assoc(:menu_items, with: &Database.Models.MenuItem.changeset/2)
      |> validate_required([:name, :google_place_id, :moderation_state])
      |> Database.Slugs.Name.maybe_generate_slug
      |> Database.Slugs.Name.unique_constraint
      |> unique_constraint(:google_place_id)
  end
end
