defmodule Graphql.Inputs do
  use Absinthe.Schema.Notation

  input_object :identity do
    field :id, non_null(:id)
  end

  input_object :list_parameters do
    field :limit, :integer
  end
end
