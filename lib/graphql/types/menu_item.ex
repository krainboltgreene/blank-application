defmodule Graphql.Types.MenuItem do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  object :menu_item do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :body, non_null(:string)
    field :moderation_state, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :allergies, list_of(non_null(:allergy)), resolve: dataloader(Database.Models.Allergy)
    field :diets, list_of(non_null(:diet)), resolve: dataloader(Database.Models.Diet)
    field :establishment, non_null(:establishment), resolve: dataloader(Database.Models.Establishment)
    field :tags, list_of(non_null(:tag)), resolve: dataloader(Database.Models.Tag)
  end
end
