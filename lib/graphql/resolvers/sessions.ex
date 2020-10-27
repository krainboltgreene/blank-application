defmodule Graphql.Resolvers.Sessions do
  @spec find(any, any, %{context: %{current_account: %{id: String.t()}}}) ::
          {:ok, %{id: String.t()}}
  def find(_parent, _arguments, %{context: %{current_account: %{id: id}}})
      when not is_nil(id) do
    {:ok, %{id: id}}
  end

  @spec find(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
  def find(_parent, _arguments, %{context: %{current_account: current_account}})
      when is_nil(current_account) do
    {:error, :unauthenticated}
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
