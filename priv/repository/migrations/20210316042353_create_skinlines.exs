defmodule Database.Repository.Migrations.CreateSkinlines do
  use Ecto.Migration

  def change do
    create table(:skinlines, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :external_id, :integer, null: false
      add :name, :text, null: false
      add :universe_id, references(:universes, on_delete: :nothing, type: :binary_id)
      add :league_data, :jsonb
      add :community_data, :jsonb

      timestamps()
    end

    create index(:skinlines, [:universe_id])
    create index(:skinlines, [:external_id])
  end
end
