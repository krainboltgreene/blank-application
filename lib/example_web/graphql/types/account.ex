defmodule ExampleWeb.Graphql.Types.Account do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Example.Database.Repo

  object :account do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :name, :string
    field :username, :string
    field :organizations, list_of(:organization)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end
end
