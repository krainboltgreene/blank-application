defmodule Henosis.Repo.Migrations.CreateElixirFunctions do
  use Ecto.Migration

  def change do
    create table(:elixir_functions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :hash, :string, null: false
      add :slug, :text, null: false
      add :documentation, :text, null: false
      add :declaration, :text, null: false
      add :inputs, :text, null: false
      add :typespec, :map, null: false
      add :guards, :text, null: false
      add :body, :text, null: false
      add :ast, :text, null: false
      add :source, :text, null: false
      add :elixir_module_id, references(:elixir_modules, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps()
    end

    create unique_index(:elixir_functions, [:slug, :elixir_module_id])
    create index(:elixir_functions, [:elixir_module_id])
  end
end
