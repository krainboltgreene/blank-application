defmodule HenosisWeb.Graphql.Types.ElixirFunction do
  use Absinthe.Schema.Notation

  object :elixir_function do
    field :id, non_null(:id)
    field :declaration, non_null(:string)
    field :documentation, non_null(:string)
    field :typespec, non_null(:typespec)
    field :guards, non_null(:string)
    field :inputs, non_null(:string)
    field :name, non_null(:string)
    field :body, non_null(:string)
    field :ast, non_null(:string)
    field :source, non_null(:string)
    field :slug, non_null(:string)
    field :deployment_state, non_null(:string)
    field :hash, non_null(:string)
    field :elixir_module, non_null(:elixir_module)

    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end
end
