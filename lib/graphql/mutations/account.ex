defmodule Graphql.Mutations.Account do
  @moduledoc false
  import Graphql.Resolvers, only: :macros
  use Absinthe.Schema.Notation

  input_object :new_account do
    field :username, :string
    field :email_address, non_null(:string)
    field :password, :string
  end

  input_object :account_changeset do
    field :id, non_null(:id)
    field :username, :string
    field :email_address, :string
    field :password, :string
  end

  input_object :account_confirmation do
    field :confirmation_secret, non_null(:string)
    field :password, non_null(:string)
  end

  object :account_mutations do
    @desc "Create a new account"
    field :create_account, :account do
      arg(:input, non_null(:new_account))

      resolve(&create/3)
      middleware(&Graphql.Middlewares.Sessions.update_session_id/2)
    end

    @desc "Update an existing account"
    field :update_account, :account do
      arg(:input, non_null(:account_changeset))

      resolve(&update/3)
    end

    @desc "Confirm an existing account"
    field :confirm_account, :account do
      arg(:input, non_null(:account_confirmation))

      resolve(&confirm/3)
      middleware(&Graphql.Middlewares.Sessions.update_session_id/2)
    end

    @desc "Permanently delete an existing account"
    field :destroy_account, :account do
      arg(:input, non_null(:identity))

      resolve(&destroy/3)
    end
  end

  listable(Database.Models.Account, :authenticated)
  findable(Database.Models.Account, :authenticated)
  updatable(Database.Models.Account, :authenticated)
  destroyable(Database.Models.Account, :authenticated)

  @spec create(
          any,
          %{
            input:
              %{email_address: String.t(), password: String.t()} | %{email_address: String.t()}
          },
          any
        ) ::
          {:ok, Database.Models.Account.t()}
          | {:error, Database.Models.Account.t() | Ecto.Changeset.t()}
  def create(
        _parent,
        %{input: %{email_address: email_address, password: password} = input},
        _resolution
      )
      when is_bitstring(email_address) and is_bitstring(password) do
    Database.Models.Account.create(input)
  end

  def create(_parent, %{input: %{email_address: email_address} = input}, _resolution)
      when is_bitstring(email_address) do
    Database.Models.Account.create(input)
  end

  @spec confirm(any, %{input: %{confirmation_secret: String.t(), password: String.t()}}, any) ::
          {:ok, Database.Models.Account.t()}
          | {:error,
             Database.Models.Account.t() | Ecto.Changeset.t(Database.Models.Account.t()) | atom}
  def confirm(
        _parent,
        %{input: %{confirmation_secret: confirmation_secret, password: password}},
        _resolution
      )
      when is_bitstring(confirmation_secret) and is_bitstring(password) do
    Database.Models.Account
    |> Database.Repository.get_by(confirmation_secret: confirmation_secret)
    |> case do
      nil -> {:error, :not_found}
      account -> Database.Models.Account.confirm!(account, password)
    end
  end
end
