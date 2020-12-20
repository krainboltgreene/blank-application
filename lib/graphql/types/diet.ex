defmodule Graphql.Types.Diet do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  object :diet do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :menu_items, list_of(non_null(:menu_item)), resolve: dataloader(Database.Models.MenuItem)
  end
end
