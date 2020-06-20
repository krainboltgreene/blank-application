defmodule HenosisWeb.Graphql.Types.Permission do
  use Absinthe.Schema.Notation

  object :permission do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end
end
