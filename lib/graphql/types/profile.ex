defmodule Graphql.Types.Profile do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :profile do
    field :id, non_null(:id)
    field :public_name, :string
  end
end
