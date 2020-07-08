defmodule Database.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :citext, null: false
      add :unconfirmed_email, :citext
      add :username, :citext
      add :name, :text
      add :onboarding_state, :citext, null: false
      add :role_state, :citext, null: false
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:accounts, [:email])
    create index(:accounts, :onboarding_state)
    create index(:accounts, :role_state)
  end
end
