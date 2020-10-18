defmodule Release.Tasks do
  require Logger

  @spec setup :: [any]
  def setup do
    Application.load(:clumsy_chinchilla)
    migrate()
    # seed()
  end

  @spec migrate :: [any]
  def migrate do
    Application.load(:clumsy_chinchilla)

    for repo <- Application.fetch_env!(:clumsy_chinchilla, :ecto_repos) do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  @spec rollback(atom, any) :: {:ok, any, any}
  def rollback(repo, version) do
    Application.load(:clumsy_chinchilla)
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end
end
