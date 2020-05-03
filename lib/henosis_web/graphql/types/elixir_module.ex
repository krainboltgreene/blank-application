defmodule HenosisWeb.Graphql.Types.ElixirModule do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Henosis.Database.Repo

  object :elixir_module do
    field :id, non_null(:id)
    field :documentation, non_null(:string)
    field :name, non_null(:string)
    field :body, non_null(:string)
    field :ast, non_null(:string)
    field :source, non_null(:string)
    field :slug, non_null(:string)
    field :deployment_state, non_null(:string)
    field :hash, non_null(:string)
    field :elixir_funcions, list_of(:elixir_function)

    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end
end
