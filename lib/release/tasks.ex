defmodule Release.Tasks do
  require Logger

  @spec setup :: [any]
  def setup do
    Application.load(:find_reel_love)
    migrate()
    # seed()
  end

  @spec migrate :: [any]
  def migrate do
    Application.load(:find_reel_love)

    for repo <- Application.fetch_env!(:find_reel_love, :ecto_repos) do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  @spec rollback(atom, any) :: {:ok, any, any}
  def rollback(repo, version) do
    Application.load(:find_reel_love)
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end
end
