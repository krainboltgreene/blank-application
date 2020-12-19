defmodule Graphql.Mutations.Settings do
  @moduledoc false
  require Logger
  use Absinthe.Schema.Notation

  input_object :settings_changeset do
    field :id, non_null(:id)
    field :light_mode, :boolean
  end

  object :settings_mutations do
    @desc "Update an existing settings"
    field :update_settings, :settings do
      arg(:input, non_null(:settings_changeset))

      resolve(&update/3)
    end
  end

  @spec update(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
  def update(_parent, _arguments, %{context: %{current_account: nil}}), do: {:error, :unauthenticated}
  @spec update(
          any,
          %{input: %{light_mode: boolean}},
          %{context: %{current_account: Database.Models.Account.t}}
        ) ::
        {:ok, Database.Models.Settings.t} | {:error, Ecto.Changeset.t}
  def update(_parent, %{input: input}, %{context: %{current_account: current_account}}) do
    current_account
    |> Database.Models.Account.changeset(%{settings: input})
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.update(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
    |> case do
      {status, record} -> {status, record |> Map.get(:settings)}
    end
  end
end
