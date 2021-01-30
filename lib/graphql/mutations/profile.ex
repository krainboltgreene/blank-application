defmodule Graphql.Mutations.Profile do
  @moduledoc false
  require Logger
  use Absinthe.Schema.Notation

  input_object :profile_changeset do
    field :id, non_null(:id)
    field :public_name, :string
  end

  object :profile_mutations do
    @desc "Update an existing profile"
    field :update_profile, :profile do
      arg(:input, non_null(:profile_changeset))

      resolve(&update/3)
    end
  end

  @spec update(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
  def update(_parent, _arguments, %{context: %{current_account: nil}}),
    do: {:error, :unauthenticated}

  @spec update(
          any,
          %{input: %{public_name: String.t}},
          %{context: %{current_account: Database.Models.Account.t()}}
        ) ::
          {:ok, Database.Models.Profile.t()} | {:error, Ecto.Changeset.t()}
  def update(_parent, %{input: input}, %{context: %{current_account: current_account}}) do
    current_account
    |> Database.Models.Account.changeset(%{profile: input})
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.update(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
    # TODO: Make embedded a lot easier
    |> case do
      {status, record} -> {status, record |> Map.get(:profile)}
    end
  end
end
