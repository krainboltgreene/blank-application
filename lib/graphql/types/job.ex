defmodule Graphql.Types.Job do
  use Absinthe.Schema.Notation

  object :job do
    field :status, non_null(:string)
  end
end
