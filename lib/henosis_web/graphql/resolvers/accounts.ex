defmodule HenosisWeb.Graphql.Resolvers.Accounts do
  @spec list(any, any, any) :: {:ok, [%Henosis.Models.Account{}]} | {:error, any}
  def list(_parent, _arguments, _resolution) do
    {:ok, Henosis.Database.Repo.all(Henosis.Models.Account)}
  end

  @spec find(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Henosis.Models.Account{}} | {:error, any}
  def find(_parent, %{input: %{id: id}}, _resolution) when not is_nil(id) and is_bitstring(id) do
    {:ok, Henosis.Database.Repo.get(Henosis.Models.Account, id)}
  end

  @spec create(any, %{input: %{email: bitstring, password: bitstring} | %{email: bitstring}}, any) ::
          {:ok, %Henosis.Models.Account{}} | {:error, any}
  def create(_parent, %{input: %{email: email} = input}, _resolution) do
    default_attributes = %{
      username: List.first(String.split(email, "@")),
      password:
        input[:password] ||
          :crypto.strong_rand_bytes(24) |> Base.encode32(case: :upper) |> binary_part(0, 24)
    }

    attributes = Map.merge(default_attributes, input)

    %Henosis.Models.Account{}
    |> Henosis.Models.Account.changeset(attributes)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Henosis.Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec update(any, %{input: %{:id => bitstring, optional(atom) => any}}, any) ::
          {:ok, %Henosis.Models.Account{}} | {:error, any}
  def update(_parent, %{input: %{id: id} = input}, _resolution) when is_bitstring(id) do
    Henosis.Database.Repo.get!(Henosis.Models.Account, id)
    |> Henosis.Models.Account.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Henosis.Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec destroy(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Henosis.Models.Account{}} | {:error, any}
  def destroy(_parent, %{input: %{id: id}}, _resolution)
      when not is_nil(id) and is_bitstring(id) do
    Henosis.Database.Repo.get(Henosis.Models.Account, id)
    |> Henosis.Database.Repo.delete()
  end

  @spec grant_administration_powers(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Henosis.Models.Account{}} | {:error, any}
  def grant_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Henosis.Database.Repo.get!(Henosis.Models.Account, id)
    |> Henosis.Models.Account.grant_administrator_powers!()
  end

  @spec revoke_administration_powers(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Henosis.Models.Account{}} | {:error, any}
  def revoke_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    Henosis.Database.Repo.get!(Henosis.Models.Account, id)
    |> Henosis.Models.Account.revoke_administrator_powers!()
  end
end
