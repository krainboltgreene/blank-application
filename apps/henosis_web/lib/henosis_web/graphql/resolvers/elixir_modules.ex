defmodule HenosisWeb.Graphql.Resolvers.ElixirModules do
  @spec list(any, any, any) :: {:ok, [%Henosis.Models.ElixirModule{}]} | {:error, any}
  def list(_parent, _arguments, _resolution) do
    {:ok, Database.Repo.all(Henosis.Models.ElixirModule)}
  end

  @spec find(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Henosis.Models.ElixirModule{}} | {:error, any}
  def find(_parent, %{input: %{id: id}}, _resolution) when not is_nil(id) and is_bitstring(id) do
    {:ok, Database.Repo.get(Henosis.Models.ElixirModule, id)}
  end

  @spec create(any, %{input: map}, any) :: {:ok, %Henosis.Models.ElixirModule{}} | {:error, any}
  def create(_parent, %{input: input}, _resolution) do
    %Henosis.Models.ElixirModule{}
    |> Henosis.Models.ElixirModule.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec update(any, %{input: %{:id => bitstring, optional(atom) => any}}, any) ::
          {:ok, %Henosis.Models.ElixirModule{}} | {:error, any}
  def update(_parent, %{input: %{id: id} = input}, _resolution) when is_bitstring(id) do
    Database.Repo.get!(Henosis.Models.ElixirModule, id)
    |> Henosis.Models.ElixirModule.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec destroy(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Henosis.Models.ElixirModule{}} | {:error, any}
  def destroy(_parent, %{input: %{id: id}}, _resolution)
      when not is_nil(id) and is_bitstring(id) do
    Database.Repo.get(Henosis.Models.ElixirModule, id)
    |> Database.Repo.delete()
  end
end
