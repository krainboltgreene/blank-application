defmodule HenosisWeb.Graphql.Queries.ElixirFunction do
  use Absinthe.Schema.Notation

  object :elixir_function_queries do
    @desc "Get all elixir_functions"
    field :elixir_functions, list_of(:elixir_function) do
      middleware(&HenosisWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&HenosisWeb.Graphql.Resolvers.ElixirFunctions.list/3)
    end

    @desc "Get an elixir_function by id"
    field :elixir_function, :elixir_function do
      arg(:id, non_null(:id))

      middleware(&HenosisWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&HenosisWeb.Graphql.Resolvers.ElixirFunctions.find/3)
    end
  end
end
