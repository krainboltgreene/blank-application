defmodule Database.Repo.Migrations.AddProfileToAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :profile, :map, default: %{}, null: false
    end
  end
end
