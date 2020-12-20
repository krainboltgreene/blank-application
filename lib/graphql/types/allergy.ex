defmodule Graphql.Types.Allergy do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  object :allergy do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :menu_items, list_of(non_null(:menu_item)), resolve: dataloader(Database.Models.MenuItem)
  end
end
