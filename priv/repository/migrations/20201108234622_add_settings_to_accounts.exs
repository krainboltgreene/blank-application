defmodule Database.Repo.Migrations.AddSettingsToAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :settings, :map, default: %{}, null: false
    end
  end
end
