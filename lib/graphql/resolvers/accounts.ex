defmodule Graphql.Resolvers.Accounts do
  @moduledoc false
  import Graphql.Resolvers, only: :macros

  listable(Database.Models.Account, :authenticated)
  findable(Database.Models.Account, :authenticated)
  updatable(Database.Models.Account, :authenticated)
  destroyable(Database.Models.Account, :authenticated)

  @spec create(any, %{input: %{email_address: String.t, password: String.t} | %{email_address: String.t}}, any) :: {:ok, Database.Models.Account.t()} | {:error, Database.Models.Account.t() | Ecto.Changeset.t()}
  def create(_parent, %{input: %{email_address: email_address, password: password} = input}, _resolution) when is_bitstring(email_address) and is_bitstring(password) do
    Database.Models.Account.create(input)
  end
  def create(_parent, %{input: %{email_address: email_address} = input}, _resolution) when is_bitstring(email_address) do
    Database.Models.Account.create(input)
  end

  @spec grant_administration_powers(any, %{input: %{id: String.t}}, any) ::
  {:ok, Database.Models.Account.t()} | {:error, Database.Models.Account.t() | Ecto.Changeset.t()}
  def grant_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Database.Models.Account
    |> Database.Repository.get(id)
    |> case do
      nil -> {:error, :not_found}
      account -> Database.Models.Account.grant_administrator_powers!(account)
    end
  end
  def grant_administration_powers(_parent, _arguments, %{
        context: %{current_account: nil}
      }) do
    {:error, :unauthenticated}
  end

  @spec revoke_administration_powers(any, %{input: %{id: String.t}}, any) ::
  {:ok, Database.Models.Account.t()} | {:error, Database.Models.Account.t() | Ecto.Changeset.t()}
  def revoke_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Database.Models.Account
    |> Database.Repository.get(id)
    |> case do
      nil -> {:error, :not_found}
      account -> Database.Models.Account.revoke_administrator_powers!(account)
    end
  end
  def revoke_administration_powers(_parent, _arguments, %{
        context: %{current_account: nil}
      }) do
    {:error, :unauthenticated}
  end
end
