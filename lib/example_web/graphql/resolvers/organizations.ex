defmodule ExampleWeb.Graphql.Resolvers.Organizations do
  @spec list(any, any, any) :: {:ok, [%Example.Models.Organization{}]} | {:error, any}
  def list(_parent, _arguments, _resolution) do
    {:ok, Example.Database.Repo.all(Example.Models.Organization)}
  end

  @spec find(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Example.Models.Organization{}} | {:error, any}
  def find(_parent, %{input: %{id: id}}, _resolution) when not is_nil(id) and is_bitstring(id) do
    {:ok, Example.Database.Repo.get(Example.Models.Organization, id)}
  end

  @spec create(any, %{input: map}, any) :: {:ok, %Example.Models.Organization{}} | {:error, any}
  def create(_parent, %{input: input}, _resolution) do
    %Example.Models.Organization{}
    |> Example.Models.Organization.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Example.Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec update(any, %{input: %{:id => bitstring, optional(atom) => any}}, any) ::
          {:ok, %Example.Models.Organization{}} | {:error, any}
  def update(_parent, %{input: %{id: id} = input}, _resolution) when is_bitstring(id) do
    Example.Database.Repo.get!(Example.Models.Organization, id)
    |> Example.Models.Organization.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Example.Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec destroy(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Example.Models.Organization{}} | {:error, any}
  def destroy(_parent, %{input: %{id: id}}, _resolution)
      when not is_nil(id) and is_bitstring(id) do
    Example.Database.Repo.get(Example.Models.Organization, id)
    |> Example.Database.Repo.delete()
  end
end
