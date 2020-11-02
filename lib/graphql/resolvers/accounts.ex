defmodule Graphql.Resolvers.Accounts do
  @moduledoc false
  import Graphql.Resolvers, only: :macros

  listable(Database.Models.Account, :authenticated)
  findable(Database.Models.Account, :authenticated)
  updatable(Database.Models.Account, :authenticated)
  destroyable(Database.Models.Account, :authenticated)

  @spec create(any, %{input: %{email_address: String.t, password: String.t} | %{email_address: String.t}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def create(_parent, %{input: %{email_address: email_address, password: password} = input}, _resolution) when is_bitstring(email_address) and is_bitstring(password) do
    Database.Models.Account.create(input)
  end
  def create(_parent, %{input: %{email_address: email_address} = input}, _resolution) when is_bitstring(email_address) do
    Database.Models.Account.create(input)
  end

  @spec grant_administration_powers(any, %{input: %{id: String.t}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def grant_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Database.Models.Account
    |> Database.Repository.get!(id)
    |> Database.Models.Account.grant_administrator_powers!()
  end

  def grant_administration_powers(_parent, _arguments, %{
        context: %{current_account: current_account}
      })
      when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec revoke_administration_powers(any, %{input: %{id: String.t}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def revoke_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Database.Models.Account
    |> Database.Repository.get!(id)
    |> Database.Models.Account.revoke_administrator_powers!()
  end

  def revoke_administration_powers(_parent, _arguments, %{
        context: %{current_account: current_account}
      })
      when is_nil(current_account) do
    {:error, :unauthenticated}
  end
end
