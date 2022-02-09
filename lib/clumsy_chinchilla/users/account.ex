defmodule ClumsyChinchilla.Users.Account do
  @moduledoc false
  use Ecto.Schema
  import Estate, only: [state_machines: 1]
  import Ecto.Changeset

  state_machines(
    onboarding_state: [
      complete: [converted: "completed"]
    ]
  )

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field(:email_address, :string)
    field(:username, :string)
    field(:onboarding_state, :string, default: "converted")
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true
    embeds_one(:settings, ClumsyChinchilla.Users.Settings)
    embeds_one(:profile, ClumsyChinchilla.Users.Profile)
    has_many(:organization_memberships, ClumsyChinchilla.Users.OrganizationMembership)
    has_many(:organizations, through: [:organization_memberships, :organization])

    timestamps()
  end

  @type t :: %__MODULE__{
          email_address: String.t(),
          username: String.t(),
          onboarding_state: String.t(),
          password: String.t() | nil,
          hashed_password: String.t() | nil,
          settings: ClumsyChinchilla.Users.Settings.t() | nil,
          profile: ClumsyChinchilla.Users.Profile.t() | nil,
          organizations: list(ClumsyChinchilla.Users.Organization.t() | nil) | nil
        }

  @spec create(%{email_address: String.t(), password: String.t()}) ::
          {:ok, ClumsyChinchilla.Users.Account.t()}
          | {:error, Ecto.Changeset.t(ClumsyChinchilla.Users.Account.t()) | ClumsyChinchilla.Users.Account.t()}
  def create(%{email_address: email_address, password: password} = attributes)
      when is_bitstring(email_address) and is_bitstring(password) do
    ClumsyChinchilla.Users.Account.__struct__(%{
      username: List.first(String.split(email_address, "@")),
      settings: %{},
      profile: %{},
    })
    |> changeset(attributes)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> ClumsyChinchilla.Repo.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
    |> Utilities.ok_tap(fn
      account -> ClumsyChinchilla.Users.join_organization(account, "users")
    end)
    |> Utilities.ok_tap(fn
      account -> Mailer.Accounts.onboarding_email(account) |> Mailer.deliver_now()
    end)
  end

  def create(%{email_address: email_address} = attributes) when is_bitstring(email_address) do
    create(Map.merge(attributes, %{password: default_password()}))
  end

  @spec confirm!(
          %ClumsyChinchilla.Users.Account{unconfirmed_email_address: String.t() | nil},
          String.t()
        ) ::
          {:ok, ClumsyChinchilla.Users.Account.t()}
          | {:error, Ecto.Changeset.t(ClumsyChinchilla.Users.Account.t()) | ClumsyChinchilla.Users.Account.t()}
  def confirm!(%ClumsyChinchilla.Users.Account{unconfirmed_email_address: nil} = account, _) do
    {:ok, account}
  end

  def confirm!(
        %ClumsyChinchilla.Users.Account{unconfirmed_email_address: unconfirmed_email_address} = account,
        password
      )
      when is_bitstring(unconfirmed_email_address) and is_bitstring(password) do
    account
    |> changeset(%{unconfirmed_email_address: nil, password: password})
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> ClumsyChinchilla.Repo.update(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec changeset(ClumsyChinchilla.Users.Account.t(), map) ::
          Ecto.Changeset.t(ClumsyChinchilla.Users.Account.t())
  def changeset(record, attributes) do
    record
    |> Ecto.Changeset.change()
    |> set_password_hash_if_changing_password(attributes)
    |> generate_confirmation_secret_if_new_record()
    |> replace_email_address_with_unconfirmed_email_address(attributes)
    |> cast(attributes, [
      :email_address,
      :username,
      :password_hash,
      :confirmation_secret,
      :unconfirmed_email_address
    ])
    |> cast_embed(:settings)
    |> cast_embed(:profile)
    |> validate_required([:email_address])
    |> unique_constraint(:email_address)
    |> unique_constraint(:username)
  end

  defp set_password_hash_if_changing_password(changeset, %{password: password})
       when is_bitstring(password) do
    changeset |> Ecto.Changeset.change(Argon2.add_hash(password))
  end

  defp set_password_hash_if_changing_password(changeset, _), do: changeset

  defp generate_confirmation_secret_if_new_record(
         %Ecto.Changeset{data: %ClumsyChinchilla.Users.Account{id: nil}} = changeset
       ) do
    changeset |> Ecto.Changeset.change(%{confirmation_secret: Utilities.generate_secret()})
  end

  defp generate_confirmation_secret_if_new_record(changeset), do: changeset

  # If have email address, given email address, and not the same then remove given email address and update unconfirmed
  # If have email address, given email address, and the same then remove given email address and return changeset
  defp replace_email_address_with_unconfirmed_email_address(
         %Ecto.Changeset{data: %ClumsyChinchilla.Users.Account{email_address: recorded_email_address}} =
           changeset,
         %{email_address: unconfirmed_email_address} = attributes
       )
       when is_bitstring(recorded_email_address) and is_bitstring(unconfirmed_email_address) do
    Map.delete(attributes, :email_address)

    if unconfirmed_email_address != recorded_email_address do
      changeset |> Ecto.Changeset.change(%{unconfirmed_email_address: unconfirmed_email_address})
    else
      changeset
    end
  end

  # If have no email address, and given email, remove given email address and update confirmed
  defp replace_email_address_with_unconfirmed_email_address(
         %Ecto.Changeset{data: %ClumsyChinchilla.Users.Account{email_address: nil}} = changeset,
         %{email_address: unconfirmed_email_address} = attributes
       )
       when is_bitstring(unconfirmed_email_address) do
    Map.delete(attributes, :email_address)

    changeset |> Ecto.Changeset.change(%{unconfirmed_email_address: unconfirmed_email_address})
  end

  # If maybe have email_address and given no email_address then return changeset
  defp replace_email_address_with_unconfirmed_email_address(changeset, _), do: changeset

  defp default_password(), do: Utilities.generate_secret()


  @doc """
  A account changeset for registration.

  It is important to validate the length of both email and password.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def registration_changeset(account, attrs, opts \\ []) do
    account
    |> cast(attrs, [:email, :password])
    |> validate_email()
    |> validate_password(opts)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, ClumsyChinchilla.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 72)
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      # If using Bcrypt, then further validate it is at most 72 bytes long
      |> validate_length(:password, max: 72, count: :bytes)
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  @doc """
  A account changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(account, attrs) do
    account
    |> cast(attrs, [:email])
    |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A account changeset for changing the password.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def password_changeset(account, attrs, opts \\ []) do
    account
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password(opts)
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(account) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(account, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no account or the account doesn't have a password, we call
  `Bcrypt.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%ClumsyChinchilla.User.Account{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end
end
