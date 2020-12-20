defmodule Graphql.Types.Establishment do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  object :establishment do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :moderation_state, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :menu_items, list_of(non_null(:menu_item)), resolve: dataloader(Database.Models.MenuItem)
    field :payment_types, list_of(non_null(:payment_type)), resolve: dataloader(Database.Models.PaymentType)
    field :reviews, list_of(non_null(:review)), resolve: dataloader(Database.Models.Review)
    field :tags, list_of(non_null(:tag)), resolve: dataloader(Database.Models.Tag)
  end
end
