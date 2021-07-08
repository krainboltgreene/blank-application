defmodule Graphql.Types.Answer do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  object :answer do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :question, non_null(:question), resolve: dataloader(Database.Models.Question)
    field :critiques, list_of(non_null(:critique)), resolve: dataloader(Database.Models.Critique)
  end
end
