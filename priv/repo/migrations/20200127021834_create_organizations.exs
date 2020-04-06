defmodule Blank.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :slug, :citext, null: false

      timestamps()
    end

    create unique_index(:organizations, [:slug])
  end
end
