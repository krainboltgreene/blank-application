defmodule ClumsyChinchillaWeb.Graphql.Resolvers.Accounts do
  @spec list(any, any, any) :: {:ok, [%ClumsyChinchilla.Models.Account{}]} | {:error, any}
  def list(_parent, _arguments, _resolution) do
    {:ok, ClumsyChinchilla.Database.Repo.all(ClumsyChinchilla.Models.Account)}
  end

  @spec find(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %ClumsyChinchilla.Models.Account{}} | {:error, any}
  def find(_parent, %{input: %{id: id}}, _resolution) when not is_nil(id) and is_bitstring(id) do
    {:ok, ClumsyChinchilla.Database.Repo.get(ClumsyChinchilla.Models.Account, id)}
  end

  @spec create(any, %{input: %{email: bitstring, password: bitstring} | %{email: bitstring}}, any) ::
          {:ok, %ClumsyChinchilla.Models.Account{}} | {:error, any}
  def create(_parent, %{input: %{email: email} = input}, _resolution) do
    default_attributes = %{
      username: List.first(String.split(email, "@")),
      password:
        input[:password] ||
          :crypto.strong_rand_bytes(24) |> Base.encode32(case: :upper) |> binary_part(0, 24)
    }

    attributes = Map.merge(default_attributes, input)

    %ClumsyChinchilla.Models.Account{}
    |> ClumsyChinchilla.Models.Account.changeset(attributes)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> ClumsyChinchilla.Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec update(any, %{input: %{:id => bitstring, optional(atom) => any}}, any) ::
          {:ok, %ClumsyChinchilla.Models.Account{}} | {:error, any}
  def update(_parent, %{input: %{id: id} = input}, _resolution) when is_bitstring(id) do
    ClumsyChinchilla.Database.Repo.get!(ClumsyChinchilla.Models.Account, id)
    |> ClumsyChinchilla.Models.Account.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> ClumsyChinchilla.Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec destroy(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %ClumsyChinchilla.Models.Account{}} | {:error, any}
  def destroy(_parent, %{input: %{id: id}}, _resolution)
      when not is_nil(id) and is_bitstring(id) do
    ClumsyChinchilla.Database.Repo.get(ClumsyChinchilla.Models.Account, id)
    |> ClumsyChinchilla.Database.Repo.delete()
  end

  @spec grant_administration_powers(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %ClumsyChinchilla.Models.Account{}} | {:error, any}
  def grant_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    ClumsyChinchilla.Database.Repo.get!(ClumsyChinchilla.Models.Account, id)
    |> ClumsyChinchilla.Models.Account.grant_administrator_powers!()
  end

  @spec revoke_administration_powers(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %ClumsyChinchilla.Models.Account{}} | {:error, any}
  def revoke_administration_powers(_parent, %{input: %{id: id}}, _resolution)
      when is_bitstring(id) do
    ClumsyChinchilla.Database.Repo.get!(ClumsyChinchilla.Models.Account, id)
    |> ClumsyChinchilla.Models.Account.revoke_administrator_powers!()
  end
end
