defmodule Graphql.Queries.Session do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :session_queries do
    @desc "Get current session"
    field :session, :session do
      resolve(&find/3)
    end
  end

  @spec find(any, any, %{context: %{current_account: Database.Models.Account.t()}}) ::
          {:ok, %{id: String.t()}}
  def find(_parent, _arguments, %{context: %{current_account: %{id: id} = current_account}})
      when not is_nil(id) do
    {:ok, %{id: id, account: current_account}}
  end

  @spec find(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
  def find(_parent, _arguments, %{context: %{current_account: current_account}})
      when is_nil(current_account) do
    {:error, :unauthenticated}
  end
end
