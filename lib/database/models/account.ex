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
    has_many(:organization_memberships, Database.Models.OrganizationMembership)
    has_many(:organizations, through: [:organization_memberships, :organization])

    timestamps()
  end

  @spec data :: Dataloader.Ecto.t()
  def data() do
    Dataloader.Ecto.new(Database.Repository)
  end

  @spec unconfirmed?(map() | any()) :: true | false
  def unconfirmed?(%{unconfirmed_email_address: _}), do: true
  def unconfirmed?(_), do: false

  @spec create(%{:email_address => String.t, password: String.t}) :: {:ok, Database.Models.Account} | {:error, Ecto.Changeset.t() | Database.Models.Account}
  def create(%{email_address: email_address, password: password} = attributes) when is_bitstring(email_address) and is_bitstring(password) do
    default_attributes = %{
      username: List.first(String.split(email_address, "@"))
    }

    %Database.Models.Account{}
    |> Database.Models.Account.changeset(Map.merge(default_attributes, attributes))
    |> case do
      %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
      %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
    end
  end
  def create(%{email_address: email_address} = attributes) when is_bitstring(email_address) do
    create(Map.merge(attributes, %{password: default_password()}))
  end

  @doc false
  @spec changeset(map, map) :: Ecto.Changeset.t()
  def changeset(record, attributes) do
    record
    |> change()
    |> set_password_hash_if_changing_password(attributes)
    |> generate_unconfirmed_token_if_new_record()
    |> replace_email_address_with_unconfirmed_email_address(attributes)
    |> cast(attributes, [:email_address, :username, :name, :password_hash, :confirmation_secret, :unconfirmed_email_address])
    |> validate_required([:email_address])
    |> unique_constraint(:email_address)
    |> unique_constraint(:username)
  end

  defp set_password_hash_if_changing_password(%Ecto.Changeset{} = changeset, %{password: password}) do
    changeset |> Ecto.Changeset.change(Argon2.add_hash(password))
  end

  defp set_password_hash_if_changing_password(%Ecto.Changeset{} = changeset, _), do: changeset

  defp generate_unconfirmed_token_if_new_record(
    %Ecto.Changeset{data: %Database.Models.Account{id: id}} = changeset
  ) when is_nil(id) do
    changeset |> Ecto.Changeset.change(%{confirmation_secret: Utilities.generate_secret})
  end
  defp generate_unconfirmed_token_if_new_record(changeset) do
    changeset
  end

  # If have email address, given email address, and not the same then remove given email address and update unconfirmed
  # If have email address, given email address, and the same then remove given email address and return changeset
  defp replace_email_address_with_unconfirmed_email_address(
         %Ecto.Changeset{changes: %Database.Models.Account{email_address: recorded_email_address}} = changeset,
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
  defp replace_email_address_with_unconfirmed_email_address(%Ecto.Changeset{} = changeset, _), do: changeset

  defp default_password(), do: :crypto.strong_rand_bytes(24) |> Base.encode32(case: :upper) |> binary_part(0, 24)
end
