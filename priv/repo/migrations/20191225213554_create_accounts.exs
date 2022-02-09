defmodule ClumsyChinchilla.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email_address, :citext, null: false
      add :unconfirmed_email_address, :citext
      add :username, :citext
      add :name, :text
      add :onboarding_state, :citext, null: false
      add :confirmation_secret, :text
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:accounts, [:email_address])
    create index(:accounts, :onboarding_state)
  end
end
