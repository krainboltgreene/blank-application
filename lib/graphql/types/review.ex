defmodule Graphql.Types.Review do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  object :review do
    field :id, non_null(:id)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :body, non_null(:string)
    field :moderation_state, non_null(:string)
    field :critiques, list_of(non_null(:critique)), resolve: dataloader(Database.Models.Critique)
    field :author_account, non_null(:account), resolve: dataloader(Database.Models.Account)
  end
end
