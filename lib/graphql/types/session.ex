defmodule Graphql.Types.Session do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :session do
    field :id, :string
    field :account, :account,
      resolve: dataloader(Database.Models.Account)
  end
end
