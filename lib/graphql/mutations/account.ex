defmodule Graphql.Mutations.Account do
  use Absinthe.Schema.Notation

  input_object :new_account do
    field :username, :string
    field :email_address, non_null(:string)
    field :password, :string
    field :name, :string
  end

  input_object :account_changeset do
    field :id, non_null(:id)
    field :username, :string
    field :email_address, :string
    field :name, :string
    field :password, :string
  end

  object :account_mutations do
    @desc "Create a new account"
    field :create_account, :account do
      arg(:input, non_null(:new_account))

      resolve(&Graphql.Resolvers.Accounts.create/3)
      middleware(&Graphql.Middlewares.Sessions.update_session_id/2)
    end

    @desc "Update an existing account"
    field :update_account, :account do
      arg(:input, non_null(:account_changeset))

      resolve(&Graphql.Resolvers.Accounts.update/3)
    end

    field :grant_administration_powers, :account do
      arg(:input, non_null(:identity))

      resolve(&Graphql.Resolvers.Accounts.grant_administration_powers/3)
    end

    @desc "Permanently delete an existing account"
    field :destroy_account, :account do
      arg(:input, non_null(:identity))

      resolve(&Graphql.Resolvers.Accounts.destroy/3)
    end
  end
end
