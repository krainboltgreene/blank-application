defmodule Graphql.Types.Question do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  enum :question_kind do
    value :pick_one
    value :pick_many
  end

  object :question do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :kind, non_null(:question_kind)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :critiques, list_of(non_null(:critique)), resolve: dataloader(Database.Models.Critique)
    field :questions, list_of(non_null(:question)), resolve: dataloader(Database.Models.Question)
    field :foundational_question, :question, resolve: dataloader(Database.Models.Question)
  end
end
