defmodule Graphql.Types.Settings do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :settings do
    field :id, non_null(:id)
    field :light_mode, non_null(:boolean)
  end
end
