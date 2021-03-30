defmodule Database.Repository.Migrations.CreateChampions do
  use Ecto.Migration

  def change do
    create table(:champions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :external_id, :text, null: false
      add :name, :text, null: false
      add :league_data, :jsonb
      add :community_data, :jsonb

      timestamps()
    end
    create index(:champions, [:external_id])
  end
end
