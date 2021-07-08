defmodule Graphql.Types.Critique do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers


  object :critique do
    field :id, non_null(:id)
    field :guage, non_null(:integer)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :author_account, non_null(:account), resolve: dataloader(Database.Models.Account)
    field :review, non_null(:review), resolve: dataloader(Database.Models.Review)
    field :answer, non_null(:answer), resolve: dataloader(Database.Models.Answer)
    field :question, non_null(:question), resolve: dataloader(Database.Models.Question)
  end
end
