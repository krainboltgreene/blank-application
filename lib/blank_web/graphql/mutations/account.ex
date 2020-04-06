defmodule BlankWeb.Graphql.Mutations.Account do
  use Absinthe.Schema.Notation

  object :account_mutations do
    @desc "Create a new account"
    field :create_account, :account do
      arg(:name, :string)
      arg(:username, :string)
      arg(:email, non_null(:string))
      arg(:password, :string)

      resolve(&BlankWeb.Graphql.Resolvers.Accounts.create/3)
      middleware(&BlankWeb.Graphql.Middlewares.Sessions.update_session_id/2)
    end

    @desc "Update an existing account"
    field :update_account, :account do
      arg(:input, non_null(:id))

      # arg :example, :type

      middleware(&BlankWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&BlankWeb.Graphql.Resolvers.Accounts.update/3)
    end

    field :grant_administration_powers, :account do
      arg(:input, non_null(:id))

      middleware(&BlankWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&BlankWeb.Graphql.Resolvers.Accounts.grant_administration_powers/3)
    end

    @desc "Permanently delete an existing account"
    field :destroy_account, :account do
      arg(:input, non_null(:id))

      middleware(&BlankWeb.Graphql.Middlewares.Sessions.require_authentication/2)
      resolve(&BlankWeb.Graphql.Resolvers.Accounts.destroy/3)
    end
  end
end
