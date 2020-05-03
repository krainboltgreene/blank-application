defmodule ClumsyChinchillaWeb.Graphql.Types.Organization do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: ClumsyChinchilla.Database.Repo

  object :organization do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :accounts, non_null(list_of(:account))
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end
end
