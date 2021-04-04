defmodule Graphql.Types.Session do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :session do
    field :id, :string
    field :account, non_null(:account)
  end
end
