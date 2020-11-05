defmodule Graphql.Mutations.Session do
  @moduledoc false
  use Absinthe.Schema.Notation

  input_object :new_session do
    field :email_address, non_null(:string)
    field :password, non_null(:string)
  end

  object :session_mutations do
    @desc "Create a new session"
    field :create_session, :session do
      arg(:input, non_null(:new_session))

      resolve(&create/3)
      middleware(&Graphql.Middlewares.Sessions.update_session_id/2)
    end

    @desc "Permanently delete an existing session"
    field :destroy_session, :session do
      resolve(&create/3)
      middleware(&Graphql.Middlewares.Sessions.update_session_id/2)
    end
  end

  @spec create(any, %{input: %{email_address: String.t(), password: String.t()}}, any) ::
          {:ok, %{id: String.t()}} | {:error, String.t()}
  def create(_parent, %{input: %{email_address: email_address, password: password}}, _resolution)
      when is_bitstring(email_address) and is_bitstring(password) do
    # Find the account by email_address
    Database.Models.Account
    |> Database.Repository.get_by(email_address: email_address)
    |> case do
      # Determine if the password is correct
      %Database.Models.Account{} = account ->
        {Argon2.verify_pass(password, account.password_hash), account}

      nil ->
        {:error, :incorrect_credentials}
    end
    |> case do
      # Only pass down the account id
      {true, %Database.Models.Account{id: id}} -> {:ok, %{id: id}}
      {false, _} -> {:error, :incorrect_credentials}
      {:error, message} -> {:error, message}
    end
  end

  @spec destroy(any, any, %{context: %{current_account: %{id: String.t()}}}) ::
          {:ok, %{id: String.t()}}
  def destroy(_parent, _arguments, %{context: %{current_account: %{id: id}}})
      when not is_nil(id) do
    {:ok, %{id: id}}
  end

  def destroy(_parent, _arguments, %{context: %{current_account: current_account}})
      when is_nil(current_account) do
    {:error, :unauthenticated}
  end
end
