defmodule Graphql.Types.Settings do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :settings do
    field :light_mode, non_null(:boolean)
  end
end
