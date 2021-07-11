defmodule Database.Repository.Migrations.CreateSkins do
  use Ecto.Migration

  def change do
    create table(:skins, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :external_id, :integer, null: false
      add :name, :text, null: false
      add :position, :integer, null: false
      add :champion_id, references(:champions, on_delete: :nothing, type: :binary_id), null: false
      add :skinline_id, references(:skinlines, on_delete: :nothing, type: :binary_id)
      add :league_data, :jsonb
      add :community_data, :jsonb

      timestamps()
    end

    create unique_index(:skins, [:position, :external_id, :champion_id])
    create index(:skins, [:external_id])
    create index(:skins, [:champion_id])
    create index(:skins, [:skinline_id])
  end
end
