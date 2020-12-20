defmodule Database.Models.EstablishmentPaymentType do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "establishment_payment_types" do
    belongs_to :establishment, Database.Models.Establishment, primary_key: true
    belongs_to :payment_type, Database.Models.PaymentType, primary_key: true
  end
end
