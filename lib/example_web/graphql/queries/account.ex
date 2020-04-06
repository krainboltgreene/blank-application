defmodule ExampleWeb.Graphql.Queries.Account do
  use Absinthe.Schema.Notation

  object :account_queries do
    @desc "Get all accounts"
    field :accounts, list_of(:account) do
      middleware(&ExampleWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&ExampleWeb.Graphql.Resolvers.Accounts.list/3)
    end

    @desc "Get an account by id"
    field :account, :account do
      arg(:id, non_null(:id))

      middleware(&ExampleWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&ExampleWeb.Graphql.Resolvers.Accounts.find/3)
    end
  end
end
