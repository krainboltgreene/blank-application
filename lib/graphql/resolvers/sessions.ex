defmodule Graphql.Resolvers.Sessions do
  @spec create(any, %{input: %{email: bitstring, password: bitstring}}, any) ::
          {:ok, %{id: bitstring}} | {:error, bitstring}
  def create(_parent, %{input: %{email: email, password: password}}, _resolution)
      when is_bitstring(email) and is_bitstring(password) do
    # Find the account by email
    Database.Repo.get_by(Poutioner.Models.Account, email: email)
    |> case do
      # Determine if the password is correct
      %Database.Models.Account{} = account ->
        {Argon2.verify_pass(password, account.password_hash), account}

      nil ->
        {:error, "Login credentials were invalid or the account doesn't exist"}
    end
    |> case do
      # Only pass down the account id
      {true, %Database.Models.Account{id: id}} -> {:ok, %{id: id}}
      {false, _} -> {:error, "Login credentials were invalid or the account doesn't exist"}
      {:error, message} -> {:error, message}
    end
  end

  @spec destroy(any, any, %{context: %{current_account: %{id: String.t()}}}) :: {:ok, %{id: String.t()}}
  def destroy(_parent, _arguments, %{context: %{current_account: %{id: id}}})
      when not is_nil(id) do
    {:ok, %{id: id}}
  end
  def destroy(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end

  @spec find(any, any, %{context: %{current_account: %{id: String.t()}}}) :: {:ok, %{id: String.t()}}
  def find(_parent, _arguments, %{context: %{current_account: %{id: id}}})
      when not is_nil(id) do
    {:ok, %{id: id}}
  end
  def find(_parent, _arguments, %{context: %{current_account: current_account}}) when is_nil(current_account) do
    {:error, :unauthenticated}
  end
end
