defmodule Graphql.Types.PaymentType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  object :payment_type do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :establishment, non_null(:establishment), resolve: dataloader(Database.Models.Establishment)
  end
end
