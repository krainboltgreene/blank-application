defmodule Graphql.Types.Account do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :account do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :name, :string
    field :username, :string

    field :organizations, list_of(:organization),
      resolve: dataloader(Database.Models.Organization)

    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end
end
