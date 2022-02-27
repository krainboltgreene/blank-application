defmodule Core.Users do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false

  ## Database getters

  @doc """
  Gets a account by email_address.

  ## Examples

      iex> get_account_by_email_address("foo@example.com")
      %Core.Users.Account{}

      iex> get_account_by_email_address("unknown@example.com")
      nil

  """
  def get_account_by_email_address(email_address) when is_binary(email_address) do
    Core.Repo.get_by(Core.Users.Account, email_address: email_address)
  end

  @doc """
  Gets a account by email and password.

  ## Examples

      iex> get_account_by_email_address_and_password("foo@example.com", "correct_password")
      %Core.Users.Account{}

      iex> get_account_by_email_address_and_password("foo@example.com", "invalid_password")
      nil

  """
  def get_account_by_email_address_and_password(email_address, password)
      when is_binary(email_address) and is_binary(password) do
    account = Core.Repo.get_by(Core.Users.Account, email_address: email_address)
    if Core.Users.Account.valid_password?(account, password), do: account
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Core.Users.Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Core.Repo.get!(Core.Users.Account, id)

  ## Account registration

  @doc """
  Registers a account.

  ## Examples

      iex> register_account(%{field: value})
      {:ok, %Core.Users.Account{}}

      iex> register_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_account(attrs) do
    %Core.Users.Account{}
    |> Core.Users.Account.registration_changeset(attrs)
    |> Core.Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account_registration(account)
      %Ecto.Changeset{data: %Core.Users.Account{}}

  """
  def change_account_registration(%Core.Users.Account{} = account, attrs \\ %{}) do
    Core.Users.Account.registration_changeset(account, attrs, hash_password: false)
  end

  ## Settings

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the account email_address.

  ## Examples

      iex> change_account_email_address(account)
      %Ecto.Changeset{data: %Core.Users.Account{}}

  """
  def change_account_email_address(account, attrs \\ %{}) do
    Core.Users.Account.email_address_changeset(account, attrs)
  end

  @doc """
  Emulates that the email_address will change without actually changing
  it in the database.

  ## Examples

      iex> apply_account_email_address(account, "valid password", %{email_address: ...})
      {:ok, %Core.Users.Account{}}

      iex> apply_account_email_address(account, "invalid password", %{email_address: ...})
      {:error, %Ecto.Changeset{}}

  """
  def apply_account_email_address(account, password, attrs) do
    account
    |> Core.Users.Account.email_address_changeset(attrs)
    |> Core.Users.Account.validate_current_password(password)
    |> Ecto.Changeset.apply_action(:update)
  end

  @doc """
  Updates the account email_address using the given token.

  If the token matches, the account email_address is updated and the token is deleted.
  The confirmed_at date is also updated to the current time.
  """
  def update_account_email_address(account, token) do
    context = "change:#{account.email_address}"

    with {:ok, query} <- Core.Users.AccountToken.verify_change_email_token_query(token, context),
         %Core.Users.AccountToken{sent_to: email_address} <- Core.Repo.one(query),
         {:ok, _} <-
           Core.Repo.transaction(
             account_email_address_multi(account, email_address, context)
           ) do
      :ok
    else
      _ -> :error
    end
  end

  defp account_email_address_multi(account, email_address, context) do
    changeset =
      account
      |> Core.Users.Account.email_address_changeset(%{email_address: email_address})
      |> Core.Users.Account.confirm_changeset()

    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, changeset)
    |> Ecto.Multi.delete_all(
      :tokens,
      Core.Users.AccountToken.account_and_contexts_query(account, [context])
    )
  end

  @doc """
  Delivers the update email instructions to the given account.

  ## Examples

      iex> deliver_update_email_address_instructions(account, current_email_address, &Routes.account_update_email_address_url(conn, :edit, &1))
      {:ok, %{to: ..., body: ...}}

  """
  def deliver_update_email_address_instructions(
        %Core.Users.Account{} = account,
        current_email_address,
        update_email_address_url_fun
      )
      when is_function(update_email_address_url_fun, 1) do
    {encoded_token, account_token} =
      Core.Users.AccountToken.build_email_token(account, "change:#{current_email_address}")

    Core.Repo.insert!(account_token)

    Core.Users.AccountNotifier.deliver_update_email_address_instructions(
      account,
      update_email_address_url_fun.(encoded_token)
    )
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the account password.

  ## Examples

      iex> change_account_password(account)
      %Ecto.Changeset{data: %Core.Users.Account{}}

  """
  def change_account_password(account, attrs \\ %{}) do
    Core.Users.Account.password_changeset(account, attrs, hash_password: false)
  end

  @doc """
  Updates the account password.

  ## Examples

      iex> update_account_password(account, "valid password", %{password: ...})
      {:ok, %Core.Users.Account{}}

      iex> update_account_password(account, "invalid password", %{password: ...})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_password(account, password, attrs) do
    changeset =
      account
      |> Core.Users.Account.password_changeset(attrs)
      |> Core.Users.Account.validate_current_password(password)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, changeset)
    |> Ecto.Multi.delete_all(
      :tokens,
      Core.Users.AccountToken.account_and_contexts_query(account, :all)
    )
    |> Core.Repo.transaction()
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
    {token, account_token} = Core.Users.AccountToken.build_session_token(account)
    Core.Repo.insert!(account_token)
    token
  end

  @doc """
  Gets the account with the given signed token.
  """
  def get_account_by_session_token(token) do
    {:ok, query} = Core.Users.AccountToken.verify_session_token_query(token)
    Core.Repo.one(query)
  end

  @doc """
  Deletes the signed token with the given context.
  """
  def delete_session_token(token) do
    Core.Repo.delete_all(
      Core.Users.AccountToken.token_and_context_query(token, "session")
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
        %Core.Users.Account{} = account,
        confirmation_url_fun
      )
      when is_function(confirmation_url_fun, 1) do
    if account.confirmed_at do
      {:error, :already_confirmed}
    else
      {encoded_token, account_token} =
        Core.Users.AccountToken.build_email_token(account, "confirm")

      Core.Repo.insert!(account_token)

      Core.Users.AccountNotifier.deliver_confirmation_instructions(
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
    with {:ok, query} <- Core.Users.AccountToken.verify_email_token_query(token, "confirm"),
         %Core.Users.Account{} = account <- Core.Repo.one(query),
         {:ok, %{account: account}} <-
           Core.Repo.transaction(confirm_account_multi(account)) do
      {:ok, account}
    else
      _ -> :error
    end
  end

  defp confirm_account_multi(account) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, Core.Users.Account.confirm_changeset(account))
    |> Ecto.Multi.delete_all(
      :tokens,
      Core.Users.AccountToken.account_and_contexts_query(account, ["confirm"])
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
        %Core.Users.Account{} = account,
        reset_password_url_fun
      )
      when is_function(reset_password_url_fun, 1) do
    {encoded_token, account_token} =
      Core.Users.AccountToken.build_email_token(account, "reset_password")

    Core.Repo.insert!(account_token)

    Core.Users.AccountNotifier.deliver_reset_password_instructions(
      account,
      reset_password_url_fun.(encoded_token)
    )
  end

  @doc """
  Gets the account by reset password token.

  ## Examples

      iex> get_account_by_reset_password_token("validtoken")
      %Core.Users.Account{}

      iex> get_account_by_reset_password_token("invalidtoken")
      nil

  """
  def get_account_by_reset_password_token(token) do
    with {:ok, query} <-
           Core.Users.AccountToken.verify_email_token_query(token, "reset_password"),
         %Core.Users.Account{} = account <- Core.Repo.one(query) do
      account
    else
      _ -> nil
    end
  end

  @doc """
  Resets the account password.

  ## Examples

      iex> reset_account_password(account, %{password: "new long password", password_confirmation: "new long password"})
      {:ok, %Core.Users.Account{}}

      iex> reset_account_password(account, %{password: "valid", password_confirmation: "not the same"})
      {:error, %Ecto.Changeset{}}

  """
  def reset_account_password(account, attrs) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, Core.Users.Account.password_changeset(account, attrs))
    |> Ecto.Multi.delete_all(
      :tokens,
      Core.Users.AccountToken.account_and_contexts_query(account, :all)
    )
    |> Core.Repo.transaction()
    |> case do
      {:ok, %{account: account}} -> {:ok, account}
      {:error, :account, changeset, _} -> {:error, changeset}
    end
  end

  @spec join_organization_by_slug(Core.Users.Account.t(), String.t()) ::
          {:ok, Core.Users.Organization.t()}
          | {:error, :not_found | Ecto.Changeset.t(Core.Users.OrganizationPermission.t())}
  def join_organization_by_slug(account, organization_slug) do
    join_organization_by_slug(account, organization_slug, "default")
  end

  @spec join_organization_by_slug(Core.Users.Account.t(), String.t(), String.t()) ::
          {:ok, Core.Users.Organization.t()}
          | {:error, :not_found | Ecto.Changeset.t(Core.Users.OrganizationPermission.t())}
  def join_organization_by_slug(account, organization_slug, permission_slug) do
    Core.Users.Organization
    |> Core.Repo.get_by(%{slug: organization_slug})
    |> with_permission(permission_slug)
    |> with_organization_membership(account)
    |> case do
      {:ok, {organization_membership, permission}} ->
        Core.Users.create_organization_permission(%{organization_membership: organization_membership, permission: permission})

      error ->
        error
    end
  end

  defp with_permission(organization, permission_slug) when is_struct(organization, Core.Users.Organization) and is_bitstring(permission_slug) do
    Core.Users.Permission
      |> Core.Repo.get_by(%{slug: permission_slug})
      |> case do
        nil -> {:error, :not_found}
        permission -> {:ok, {organization, permission}}
      end
  end
  defp with_permission(nil, _), do: {:error, :not_found}
  defp with_organization_membership({:ok, {organization, permission}}, account) do
    Core.Users.create_organization_membership(%{organization: organization, account: account})
    |> case do
      {:ok, organization_membership} -> {:ok, {organization_membership, permission}}
      error -> error
    end
  end
  defp with_organization_membership({:error, message}, _), do: {:error, message}

  def create_organization_membership(attributes) do
    %Core.Users.OrganizationMembership{}
    |> Core.Users.OrganizationMembership.changeset(attributes)
    |> Core.Repo.insert()
  end

  def create_organization_permission(attributes) do
    %Core.Users.OrganizationPermission{}
    |> Core.Users.OrganizationPermission.changeset(attributes)
    |> Core.Repo.insert()
  end
end
