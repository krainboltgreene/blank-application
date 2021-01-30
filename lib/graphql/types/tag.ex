defmodule Graphql.Types.Tag do
  use Absinthe.Schema.Notation
  # import Absinthe.Resolution.Helpers

  # enum :taggable_types do
  #   # value :establishment, description: "Referencing the establishment data type"
  # end

  union :taggable do
    description("A thing that can be tagged")

    types([:establishment, :menu_item, :recipe, :review])
    # resolve_type fn
    #   %Database.Models.Establishment{}, _ -> :establishment
    # end
  end

  object :tag do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :taggables, list_of(non_null(:taggable))

    # field :establishments, list_of(non_null(:establishment)), resolve: dataloader(Database.Models.Establishment)
  end
end
