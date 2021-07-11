defmodule Database.Repository.Migrations.CreateUniverses do
  use Ecto.Migration

  def change do
    create table(:universes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :external_id, :integer, null: false
      add :name, :text, null: false
      add :league_data, :jsonb
      add :community_data, :jsonb

      timestamps()
    end

    create index(:universes, [:external_id])
  end
end
