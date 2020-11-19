defmodule Database.Models.Account do
  @moduledoc false
  use Ecto.Schema
  import Estate, only: [state_machines: 1]
  import Ecto.Changeset

  state_machines(
    onboarding_state: [
      complete: [converted: "completed"]
    ],
    role_state: [
      grant_administrator_powers: [user: "administrator"],
      revoke_administrator_powers: [administrator: "user"]
    ]
  )

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field(:email_address, :string)
    field(:unconfirmed_email_address, :string)
    field(:confirmation_secret, :string)
    field(:username, :string)
    field(:name, :string)
    field(:onboarding_state, :string, default: "converted")
    field(:role_state, :string, default: "user")
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    embeds_one(:settings, Database.Models.Settings)
    has_many(:organization_memberships, Database.Models.OrganizationMembership)
    has_many(:organizations, through: [:organization_memberships, :organization])

    timestamps()
  end

  @type t :: %__MODULE__{
    email_address: String.t(),
    unconfirmed_email_address: String.t() | nil,
    confirmation_secret: String.t(),
    username: String.t(),
    name: String.t() | nil,
    onboarding_state: String.t(),
    role_state: String.t(),
    password: String.t() | nil,
    password_hash: String.t() | nil,
    settings: Database.Models.Settings.t() | nil,
    organizations: list(Database.Models.Organization.t() | nil) | nil
  }

  @spec unconfirmed?(Database.Models.Account.t()) :: true | false
  def unconfirmed?(%{unconfirmed_email_address: nil}), do: true
  def unconfirmed?(_), do: false

  @spec create(%{email_address: String.t(), password: String.t()}) :: {:ok, Database.Models.Account.t()} | {:error, Ecto.Changeset.t(Database.Models.Account.t()) | Database.Models.Account.t()}
  def create(%{email_address: email_address, password: password} = attributes) when is_bitstring(email_address) and is_bitstring(password) do
    Database.Models.Account.__struct__(%{
      username: List.first(String.split(email_address, "@"))
    })
    |> changeset(attributes)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
    |> Utilities.ok_tap(fn
      account -> Database.Models.Organization.join(account, "users")
    end)
    |> Utilities.ok_tap(fn
      account -> Mailer.Accounts.onboarding_email(account) |> Mailer.deliver_now()
    end)
  end
  def create(%{email_address: email_address} = attributes) when is_bitstring(email_address) do
    create(Map.merge(attributes, %{password: default_password()}))
  end

  @spec confirm!(%Database.Models.Account{unconfirmed_email_address: String.t() | nil}, String.t()) :: {:ok, Database.Models.Account.t()} | {:error, Ecto.Changeset.t(Database.Models.Account.t()) | Database.Models.Account.t()}
  def confirm!(%Database.Models.Account{unconfirmed_email_address: nil} = account, _) do
    {:ok, account}
  end
  def confirm!(%Database.Models.Account{unconfirmed_email_address: unconfirmed_email_address} = account, password) when is_bitstring(unconfirmed_email_address) and is_bitstring(password) do
    account
    |> changeset(%{unconfirmed_email_address: nil, password: password})
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.update(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end

  @spec changeset(Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    record
    |> Ecto.Changeset.change()
    |> set_password_hash_if_changing_password(attributes)
    |> generate_confirmation_secret_if_new_record()
    |> replace_email_address_with_unconfirmed_email_address(attributes)
    |> cast(attributes, [:email_address, :username, :name, :password_hash, :confirmation_secret, :unconfirmed_email_address])
    |> cast_embed(:settings, with: &Database.Models.Settings.changeset/2)
    |> validate_required([:email_address])
    |> unique_constraint(:email_address)
    |> unique_constraint(:username)
  end

  defp set_password_hash_if_changing_password(changeset, %{password: password}) when is_bitstring(password) do
    changeset |> Ecto.Changeset.change(Argon2.add_hash(password))
  end
  defp set_password_hash_if_changing_password(changeset, _), do: changeset

  defp generate_confirmation_secret_if_new_record(
    %Ecto.Changeset{data: %Database.Models.Account{id: nil}} = changeset
  ) do
    changeset |> Ecto.Changeset.change(%{confirmation_secret: Utilities.generate_secret})
  end
  defp generate_confirmation_secret_if_new_record(changeset), do: changeset

  # If have email address, given email address, and not the same then remove given email address and update unconfirmed
  # If have email address, given email address, and the same then remove given email address and return changeset
  defp replace_email_address_with_unconfirmed_email_address(
          %Ecto.Changeset{data: %Database.Models.Account{email_address: recorded_email_address}} = changeset,
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
    %Ecto.Changeset{data: %Database.Models.Account{email_address: nil}} = changeset,
         %{email_address: unconfirmed_email_address} = attributes
       )
       when is_bitstring(unconfirmed_email_address) do
    Map.delete(attributes, :email_address)

    changeset |> Ecto.Changeset.change(%{unconfirmed_email_address: unconfirmed_email_address})
  end
  # If maybe have email_address and given no email_address then return changeset
  defp replace_email_address_with_unconfirmed_email_address(changeset, _), do: changeset

  defp default_password(), do: Utilities.generate_secret
end
