defmodule Graphql.Types.Session do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :session do
    field :id, :string
  end
end
