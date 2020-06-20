defmodule Database.Models.Account do
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
    field :email, :string
    field :unconfirmed_email, :string
    field :username, :string
    field :name, :string
    field :onboarding_state, :string, default: "converted"
    field :role_state, :string, default: "user"
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :organization_memberships, Database.Models.OrganizationMembership
    has_many :organizations, through: [:organization_memberships, :organization]

    timestamps()
  end

  @spec unconfirmed?(map() | any()) :: true | false
  def unconfirmed?(%{unconfirmed_email: _}), do: true
  def unconfirmed?(_), do: false

  @doc false
  @spec changeset(map, map) :: Ecto.Changeset.t()
  def changeset(record, attributes) do
    record
    |> change()
    |> set_password_hash_if_changing_password(attributes)
    |> replace_email_with_unconfirmed_email(attributes)
    |> cast(attributes, [:email, :username, :name, :password_hash, :unconfirmed_email])
    |> validate_required([:email])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  defp set_password_hash_if_changing_password(%Ecto.Changeset{} = changeset, %{password: password}) do
    changeset |> Ecto.Changeset.change(Argon2.add_hash(password))
  end

  defp set_password_hash_if_changing_password(%Ecto.Changeset{} = changeset, _), do: changeset

  # If have email, given email, and not the same then remove given email and update unconfirmed
  # If have email, given email, and the same then remove given email and return changeset
  defp replace_email_with_unconfirmed_email(
         %Ecto.Changeset{changes: %Database.Models.Account{email: recorded_email}} = changeset,
         %{email: unconfirmed_email} = attributes
       )
       when is_bitstring(recorded_email) and is_bitstring(unconfirmed_email) do
    Map.delete(attributes, :email)

    if unconfirmed_email != recorded_email do
      changeset |> Ecto.Changeset.change(%{unconfirmed_email: unconfirmed_email})
    else
      changeset
    end
  end

  # If have no email, and given email, remove given email and update confirmed
  defp replace_email_with_unconfirmed_email(
         %Ecto.Changeset{data: %Database.Models.Account{email: nil}} = changeset,
         %{email: unconfirmed_email} = attributes
       )
       when is_bitstring(unconfirmed_email) do
    Map.delete(attributes, :email)

    changeset |> Ecto.Changeset.change(%{unconfirmed_email: unconfirmed_email})
  end

  # If maybe have email and given no email then return changeset
  defp replace_email_with_unconfirmed_email(%Ecto.Changeset{} = changeset, _), do: changeset
end
