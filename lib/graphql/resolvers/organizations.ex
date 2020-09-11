defmodule Graphql.Resolvers.Organizations do
  @spec list(any, any, any) :: {:ok, [%Database.Models.Organization{}]} | {:error, any}
  def list(_parent, _arguments, _resolution) do
    {:ok, Database.Repository.all(Database.Models.Organization)}
  end

  @spec find(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Database.Models.Organization{}} | {:error, any}
  def find(_parent, %{input: %{id: id}}, _resolution) when not is_nil(id) and is_bitstring(id) do
    {:ok, Database.Repository.get(Database.Models.Organization, id)}
  end
  def find(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec create(any, %{input: map}, any) :: {:ok, %Database.Models.Organization{}} | {:error, any}
  def create(_parent, %{input: input}, _resolution) do
    %Database.Models.Organization{}
    |> Database.Models.Organization.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end
  def create(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec update(any, %{input: %{:id => bitstring, optional(atom) => any}}, any) ::
          {:ok, %Database.Models.Organization{}} | {:error, any}
  def update(_parent, %{input: %{id: id} = input}, _resolution) when is_bitstring(id) do
    Database.Repository.get!(Database.Models.Organization, id)
    |> Database.Models.Organization.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end
  def update(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec destroy(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Database.Models.Organization{}} | {:error, any}
  def destroy(_parent, %{input: %{id: id}}, _resolution)
      when not is_nil(id) and is_bitstring(id) do
    Database.Repository.get(Database.Models.Organization, id)
    |> Database.Repository.delete()
  end
  def destroy(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end
end
