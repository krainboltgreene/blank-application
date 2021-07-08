defmodule Henosis.Repo.Migrations.CreateElixirModules do
  use Ecto.Migration

  def change do
    create table(:elixir_modules, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :hash, :string, null: false
      add :slug, :text, null: false
      add :documentation, :text, null: false
      add :body, :text, null: false
      add :ast, :text, null: false
      add :source, :text, null: false
      add :deployment_state, :citext, null: false

      timestamps()
    end

    create unique_index(:elixir_modules, [:slug])
  end
end
