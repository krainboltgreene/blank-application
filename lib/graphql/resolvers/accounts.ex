defmodule Graphql.Resolvers.Accounts do
  import Graphql.Resolvers, only: :macros

  listable(Database.Models.Account, :authenticated)
  findable(Database.Models.Account, :authenticated)
  updatable(Database.Models.Account, :authenticated)
  destroyable(Database.Models.Account, :authenticated)

  @spec create(any, %{input: %{email: bitstring, password: bitstring} | %{email: bitstring}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def create(_parent, %{input: %{email: email} = input}, _resolution) do
    default_attributes = %{
      username: List.first(String.split(email, "@")),
      password:
        input[:password] ||
          :crypto.strong_rand_bytes(24) |> Base.encode32(case: :upper) |> binary_part(0, 24)
    }

    attributes = Map.merge(default_attributes, input)

    %Database.Models.Account{}
    |> Database.Models.Account.changeset(attributes)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec grant_administration_powers(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def grant_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Database.Repository.get!(Database.Models.Account, id)
    |> Database.Models.Account.grant_administrator_powers!()
  end

  def grant_administration_powers(_parent, _arguments, %{
        context: %{current_account: current_account}
      })
      when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec revoke_administration_powers(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def revoke_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Database.Repository.get!(Database.Models.Account, id)
    |> Database.Models.Account.revoke_administrator_powers!()
  end

  def revoke_administration_powers(_parent, _arguments, %{
        context: %{current_account: current_account}
      })
      when is_nil(current_account) do
    {:error, :unauthenticated}
  end
end
