defmodule ClumsyChinchilla.Users do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false

  ## Database getters

  @doc """
  Gets a account by email_address.

  ## Examples

      iex> get_account_by_email_address("foo@example.com")
      %__MODULE__.Account{}

      iex> get_account_by_email_address("unknown@example.com")
      nil

  """
  def get_account_by_email_address(email_address) when is_binary(email_address) do
    ClumsyChinchilla.Repo.get_by(__MODULE__.Account, email_address: email_address)
  end

  @doc """
  Gets a account by email and password.

  ## Examples

      iex> get_account_by_email_address_and_password("foo@example.com", "correct_password")
      %__MODULE__.Account{}

      iex> get_account_by_email_address_and_password("foo@example.com", "invalid_password")
      nil

  """
  def get_account_by_email_address_and_password(email_address, password)
      when is_binary(email_address) and is_binary(password) do
    account = ClumsyChinchilla.Repo.get_by(__MODULE__.Account, email_address: email_address)
    if __MODULE__.Account.valid_password?(account, password), do: account
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %__MODULE__.Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: ClumsyChinchilla.Repo.get!(__MODULE__.Account, id)

  ## Account registration

  @doc """
  Registers a account.

  ## Examples

      iex> register_account(%{field: value})
      {:ok, %__MODULE__.Account{}}

      iex> register_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_account(attrs) do
    %__MODULE__.Account{}
    |> __MODULE__.Account.registration_changeset(attrs)
    |> ClumsyChinchilla.Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account_registration(account)
      %Ecto.Changeset{data: %__MODULE__.Account{}}

  """
  def change_account_registration(%__MODULE__.Account{} = account, attrs \\ %{}) do
    __MODULE__.Account.registration_changeset(account, attrs, hash_password: false)
  end

  ## Settings

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the account email_address.

  ## Examples

      iex> change_account_email_address(account)
      %Ecto.Changeset{data: %__MODULE__.Account{}}

  """
  def change_account_email_address(account, attrs \\ %{}) do
    __MODULE__.Account.email_changeset(account, attrs)
  end

  @doc """
  Emulates that the email_address will change without actually changing
  it in the database.

  ## Examples

      iex> apply_account_email_address(account, "valid password", %{email_address: ...})
      {:ok, %__MODULE__.Account{}}

      iex> apply_account_email_address(account, "invalid password", %{email_address: ...})
      {:error, %Ecto.Changeset{}}

  """
  def apply_account_email_address(account, password, attrs) do
    account
    |> __MODULE__.Account.email_address_changeset(attrs)
    |> __MODULE__.Account.validate_current_password(password)
    |> Ecto.Changeset.apply_action(:update)
  end

  @doc """
  Updates the account email_address using the given token.

  If the token matches, the account email_address is updated and the token is deleted.
  The confirmed_at date is also updated to the current time.
  """
  def update_account_email_address(account, token) do
    context = "change:#{account.email_address}"

    with {:ok, query} <- __MODULE__.AccountToken.verify_change_email_token_query(token, context),
         %__MODULE__.AccountToken{sent_to: email_address} <- ClumsyChinchilla.Repo.one(query),
         {:ok, _} <-
           ClumsyChinchilla.Repo.transaction(account_email_address_multi(account, email_address, context)) do
      :ok
    else
      _ -> :error
    end
  end

  defp account_email_address_multi(account, email_address, context) do
    changeset =
      account
      |> __MODULE__.Account.email_address_changeset(%{email_address: email_address})
      |> __MODULE__.Account.confirm_changeset()

    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, changeset)
    |> Ecto.Multi.delete_all(
      :tokens,
      __MODULE__.AccountToken.account_and_contexts_query(account, [context])
    )
  end

  @doc """
  Delivers the update email instructions to the given account.

  ## Examples

      iex> deliver_update_email_address_instructions(account, current_email_address, &Routes.account_update_email_address_url(conn, :edit, &1))
      {:ok, %{to: ..., body: ...}}

  """
  def deliver_update_email_address_instructions(
        %__MODULE__.Account{} = account,
        current_email_address,
        update_email_address_url_fun
      )
      when is_function(update_email_address_url_fun, 1) do
    {encoded_token, account_token} =
      __MODULE__.AccountToken.build_email_token(account, "change:#{current_email_address}")

    ClumsyChinchilla.Repo.insert!(account_token)

    __MODULE__.AccountNotifier.deliver_update_email_address_instructions(
      account,
      update_email_address_url_fun.(encoded_token)
    )
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the account password.

  ## Examples

      iex> change_account_password(account)
      %Ecto.Changeset{data: %__MODULE__.Account{}}

  """
  def change_account_password(account, attrs \\ %{}) do
    __MODULE__.Account.password_changeset(account, attrs, hash_password: false)
  end

  @doc """
  Updates the account password.

  ## Examples

      iex> update_account_password(account, "valid password", %{password: ...})
      {:ok, %__MODULE__.Account{}}

      iex> update_account_password(account, "invalid password", %{password: ...})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_password(account, password, attrs) do
    changeset =
      account
      |> __MODULE__.Account.password_changeset(attrs)
      |> __MODULE__.Account.validate_current_password(password)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, changeset)
    |> Ecto.Multi.delete_all(
      :tokens,
      __MODULE__.AccountToken.account_and_contexts_query(account, :all)
    )
    |> ClumsyChinchilla.Repo.transaction()
    |> case do
      {:ok, %{account: account}} -> {:ok, account}
      {:error, :account, changeset, _} -> {:error, changeset}
    end
  end

  ## Session

  @doc """
  Generates a session token.
  """
  def generate_account_session_token(account) do
    {token, account_token} = __MODULE__.AccountToken.build_session_token(account)
    ClumsyChinchilla.Repo.insert!(account_token)
    token
  end

  @doc """
  Gets the account with the given signed token.
  """
  def get_account_by_session_token(token) do
    {:ok, query} = __MODULE__.AccountToken.verify_session_token_query(token)
    ClumsyChinchilla.Repo.one(query)
  end

  @doc """
  Deletes the signed token with the given context.
  """
  def delete_session_token(token) do
    ClumsyChinchilla.Repo.delete_all(
      __MODULE__.AccountToken.token_and_context_query(token, "session")
    )

    :ok
  end

  ## Confirmation

  @doc """
  Delivers the confirmation email instructions to the given account.

  ## Examples

      iex> deliver_account_confirmation_instructions(account, &Routes.account_confirmation_url(conn, :edit, &1))
      {:ok, %{to: ..., body: ...}}

      iex> deliver_account_confirmation_instructions(confirmed_account, &Routes.account_confirmation_url(conn, :edit, &1))
      {:error, :already_confirmed}

  """
  def deliver_account_confirmation_instructions(
        %__MODULE__.Account{} = account,
        confirmation_url_fun
      )
      when is_function(confirmation_url_fun, 1) do
    if account.confirmed_at do
      {:error, :already_confirmed}
    else
      {encoded_token, account_token} =
        __MODULE__.AccountToken.build_email_token(account, "confirm")

      ClumsyChinchilla.Repo.insert!(account_token)

      __MODULE__.AccountNotifier.deliver_confirmation_instructions(
        account,
        confirmation_url_fun.(encoded_token)
      )
    end
  end

  @doc """
  Confirms a account by the given token.

  If the token matches, the account account is marked as confirmed
  and the token is deleted.
  """
  def confirm_account(token) do
    with {:ok, query} <- __MODULE__.AccountToken.verify_email_token_query(token, "confirm"),
         %__MODULE__.Account{} = account <- ClumsyChinchilla.Repo.one(query),
         {:ok, %{account: account}} <-
           ClumsyChinchilla.Repo.transaction(confirm_account_multi(account)) do
      {:ok, account}
    else
      _ -> :error
    end
  end

  defp confirm_account_multi(account) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, __MODULE__.Account.confirm_changeset(account))
    |> Ecto.Multi.delete_all(
      :tokens,
      __MODULE__.AccountToken.account_and_contexts_query(account, ["confirm"])
    )
  end

  ## Reset password

  @doc """
  Delivers the reset password email to the given account.

  ## Examples

      iex> deliver_account_reset_password_instructions(account, &Routes.account_reset_password_url(conn, :edit, &1))
      {:ok, %{to: ..., body: ...}}

  """
  def deliver_account_reset_password_instructions(
        %__MODULE__.Account{} = account,
        reset_password_url_fun
      )
      when is_function(reset_password_url_fun, 1) do
    {encoded_token, account_token} =
      __MODULE__.AccountToken.build_email_token(account, "reset_password")

    ClumsyChinchilla.Repo.insert!(account_token)

    __MODULE__.AccountNotifier.deliver_reset_password_instructions(
      account,
      reset_password_url_fun.(encoded_token)
    )
  end

  @doc """
  Gets the account by reset password token.

  ## Examples

      iex> get_account_by_reset_password_token("validtoken")
      %__MODULE__.Account{}

      iex> get_account_by_reset_password_token("invalidtoken")
      nil

  """
  def get_account_by_reset_password_token(token) do
    with {:ok, query} <-
           __MODULE__.AccountToken.verify_email_token_query(token, "reset_password"),
         %__MODULE__.Account{} = account <- ClumsyChinchilla.Repo.one(query) do
      account
    else
      _ -> nil
    end
  end

  @doc """
  Resets the account password.

  ## Examples

      iex> reset_account_password(account, %{password: "new long password", password_confirmation: "new long password"})
      {:ok, %__MODULE__.Account{}}

      iex> reset_account_password(account, %{password: "valid", password_confirmation: "not the same"})
      {:error, %Ecto.Changeset{}}

  """
  def reset_account_password(account, attrs) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, __MODULE__.Account.password_changeset(account, attrs))
    |> Ecto.Multi.delete_all(
      :tokens,
      __MODULE__.AccountToken.account_and_contexts_query(account, :all)
    )
    |> ClumsyChinchilla.Repo.transaction()
    |> case do
      {:ok, %{account: account}} -> {:ok, account}
      {:error, :account, changeset, _} -> {:error, changeset}
    end
  end

  @spec join_organization_by_slug(__MODULE__.Account.t(), String.t()) ::
          {:ok, __MODULE__.Organization.t()}
          | {:error, :not_found | Ecto.Changeset.t(__MODULE__.OrganizationPermission.t())}
  def join_organization_by_slug(account, organization_slug) do
    join_organization_by_slug(account, organization_slug, "default")
  end

  @spec join_organization_by_slug(__MODULE__.Account.t(), String.t(), String.t()) ::
          {:ok, __MODULE__.Organization.t()}
          | {:error, :not_found | Ecto.Changeset.t(__MODULE__.OrganizationPermission.t())}
  def join_organization_by_slug(account, organization_slug, permission_slug) do
    __MODULE__.Organization
    |> ClumsyChinchilla.Repo.get_by(%{slug: organization_slug})
    |> case do
      nil ->
        {:error, :not_found}

      organization ->
        __MODULE__.Permission
        |> ClumsyChinchilla.Repo.get_by(%{slug: permission_slug})
        |> case do
          nil -> {:error, :not_found}
          permission -> {:ok, {organization, permission}}
        end
    end
    |> case do
      {:ok, {organization, permission}} ->
        __MODULE__.create_organization_membership(organization, account)
        |> case do
          {:ok, organization_membership} -> {:ok, {organization_membership, permission}}
          error -> error
        end

      error ->
        error
    end
    |> case do
      {:ok, {organization_membership, permission}} ->
        __MODULE__.create_organization_permission(organization_membership, permission)

      error ->
        error
    end
  end

  def create_organization_membership(organization, account) do
  end

  def create_organization_permission(organization_membership, permission) do
  end
end
