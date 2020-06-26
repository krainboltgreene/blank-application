defmodule Graphql.Resolvers.Accounts do
  @spec list(any, any, %{context: %{current_account: %Database.Models.Account{id: String.t()}}}) :: {:ok, list(%Database.Models.Account{})}
  def list(_parent, _arguments, %{context: %{current_account: current_account}}) when not is_nil(current_account) do
    {:ok, Database.Repo.all(Database.Models.Account)}
  end

  @spec list(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
  def list(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec find(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def find(_parent, %{input: %{id: id}}, _resolution) when not is_nil(id) and is_bitstring(id) do
    {:ok, Database.Repo.get(Database.Models.Account, id)}
  end
  def find(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

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
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec update(any, %{input: %{:id => bitstring, optional(atom) => any}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def update(_parent, %{input: %{id: id} = input}, _resolution) when is_bitstring(id) do
    Database.Repo.get!(Database.Models.Account, id)
    |> Database.Models.Account.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end
  def update(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec destroy(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def destroy(_parent, %{input: %{id: id}}, _resolution)
      when not is_nil(id) and is_bitstring(id) do
    Database.Repo.get(Database.Models.Account, id)
    |> Database.Repo.delete()
  end
  def destroy(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec grant_administration_powers(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def grant_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Database.Repo.get!(Database.Models.Account, id)
    |> Database.Models.Account.grant_administrator_powers!()
  end
  def grant_administration_powers(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec revoke_administration_powers(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Database.Models.Account{}} | {:error, any}
  def revoke_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Database.Repo.get!(Database.Models.Account, id)
    |> Database.Models.Account.revoke_administrator_powers!()
  end
  def revoke_administration_powers(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end
end
