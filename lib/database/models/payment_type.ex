defmodule Database.Models.PaymentType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "payment_types" do
    field :name, :string
    field :slug, :string
    many_to_many :establishment, Database.Models.Establishment, join_through: Database.Models.EstablishmentPaymentType

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    payment_type
      |> cast(attributes, [:name])
      |> validate_required([:name])
      |> unique_constraint(:name)
      |> Database.Slugs.Name.maybe_generate_slug
      |> Database.Slugs.Name.unique_constraint
  end
end
