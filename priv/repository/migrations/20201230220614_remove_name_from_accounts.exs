defmodule Database.Repository.Migrations.RemoveNameFromAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      remove(:name)
    end
  end
end
