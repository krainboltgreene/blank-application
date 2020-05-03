defmodule HenosisWeb.Graphql.Resolvers.Organizations do
  @spec list(any, any, any) :: {:ok, [%Henosis.Models.Organization{}]} | {:error, any}
  def list(_parent, _arguments, _resolution) do
    {:ok, Henosis.Database.Repo.all(Henosis.Models.Organization)}
  end

  @spec find(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Henosis.Models.Organization{}} | {:error, any}
  def find(_parent, %{input: %{id: id}}, _resolution) when not is_nil(id) and is_bitstring(id) do
    {:ok, Henosis.Database.Repo.get(Henosis.Models.Organization, id)}
  end

  @spec create(any, %{input: map}, any) :: {:ok, %Henosis.Models.Organization{}} | {:error, any}
  def create(_parent, %{input: input}, _resolution) do
    %Henosis.Models.Organization{}
    |> Henosis.Models.Organization.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Henosis.Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec update(any, %{input: %{:id => bitstring, optional(atom) => any}}, any) ::
          {:ok, %Henosis.Models.Organization{}} | {:error, any}
  def update(_parent, %{input: %{id: id} = input}, _resolution) when is_bitstring(id) do
    Henosis.Database.Repo.get!(Henosis.Models.Organization, id)
    |> Henosis.Models.Organization.changeset(input)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Henosis.Database.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec destroy(any, %{input: %{id: bitstring}}, any) ::
          {:ok, %Henosis.Models.Organization{}} | {:error, any}
  def destroy(_parent, %{input: %{id: id}}, _resolution)
      when not is_nil(id) and is_bitstring(id) do
    Henosis.Database.Repo.get(Henosis.Models.Organization, id)
    |> Henosis.Database.Repo.delete()
  end
end
