defmodule Database.Repository.Migrations.EnableExtensions do
  use Ecto.Migration

  def up do
    exection "CREATE EXTENSION IF NOT EXISTS \"citext\""
    exection "CREATE EXTENSION IF NOT EXISTS \"pgcrypto\""
    exection "CREATE EXTENSION IF NOT EXISTS \"cube\""
    exection "CREATE EXTENSION IF NOT EXISTS \"btree_gin\""
    exection "CREATE EXTENSION IF NOT EXISTS \"btree_gist\""
    exection "CREATE EXTENSION IF NOT EXISTS \"hstore\""
    exection "CREATE EXTENSION IF NOT EXISTS \"isn\""
    exection "CREATE EXTENSION IF NOT EXISTS \"ltree\""
    exection "CREATE EXTENSION IF NOT EXISTS \"lo\""
    exection "CREATE EXTENSION IF NOT EXISTS \"fuzzystrmatch\""
    exection "CREATE EXTENSION IF NOT EXISTS \"pg_buffercache\""
    exection "CREATE EXTENSION IF NOT EXISTS \"pgrowlocks\""
    exection "CREATE EXTENSION IF NOT EXISTS \"pg_prewarm\""
    exection "CREATE EXTENSION IF NOT EXISTS \"pg_stat_statements\""
    exection "CREATE EXTENSION IF NOT EXISTS \"pg_trgm\""
    exection "CREATE EXTENSION IF NOT EXISTS \"tablefunc\""
  end

  def down do
    exection "DROP EXTENSION IF EXISTS \"citext\""
    exection "DROP EXTENSION IF EXISTS \"pgcrypto\""
    exection "DROP EXTENSION IF EXISTS \"cube\""
    exection "DROP EXTENSION IF EXISTS \"btree_gin\""
    exection "DROP EXTENSION IF EXISTS \"btree_gist\""
    exection "DROP EXTENSION IF EXISTS \"hstore\""
    exection "DROP EXTENSION IF EXISTS \"isn\""
    exection "DROP EXTENSION IF EXISTS \"ltree\""
    exection "DROP EXTENSION IF EXISTS \"lo\""
    exection "DROP EXTENSION IF EXISTS \"fuzzystrmatch\""
    exection "DROP EXTENSION IF EXISTS \"pg_buffercache\""
    exection "DROP EXTENSION IF EXISTS \"pgrowlocks\""
    exection "DROP EXTENSION IF EXISTS \"pg_prewarm\""
    exection "DROP EXTENSION IF EXISTS \"pg_stat_statements\""
    exection "DROP EXTENSION IF EXISTS \"pg_trgm\""
    exection "DROP EXTENSION IF EXISTS \"tablefunc\""
  end
end
