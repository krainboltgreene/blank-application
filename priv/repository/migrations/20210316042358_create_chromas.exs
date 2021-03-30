defmodule Database.Repository.Migrations.CreateChromas do
  use Ecto.Migration

  def change do
    create table(:chromas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :external_id, :integer, null: false
      add :name, :text, null: false
      add :colors, {:array, :text}, null: false, default: []
      add :skin_id, references(:skins, on_delete: :nothing, type: :binary_id), null: false
      add :league_data, :jsonb
      add :community_data, :jsonb

      timestamps()
    end

    create index(:chromas, [:skin_id])
    create index(:chromas, [:external_id])
  end
end
