defmodule Blank.MixProject do
  use Mix.Project

  def project do
    [
      app: :blank,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Blank.Application, []},
      extra_applications: [:logger, :runtime_tools, :absinthe_plug, :google_maps]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, "~> 0.15"},
      {:ecto_enum, "~> 1.4"},
      {:ecto_autoslug_field, "~> 2.0"},
      {:paper_trail, "~> 0.8.2"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:argon2_elixir, "~> 2.1"},
      {:absinthe, "~> 1.4"},
      {:absinthe_plug, "~> 1.4"},
      {:absinthe_phoenix, "~> 1.4"},
      {:absinthe_ecto, "~> 0.1"},
      {:crudry, "~> 2.1"},
      {:comeonin, "~> 5.2"},
      {:countries, "~> 1.5"},
      {:envy, "~> 1.1"},
      {:machinery, "~> 1.0"},
      {:oban, "~> 1.0"},
      {:flippant, "~> 1.0"},
      {:google_maps, "~> 0.11"},
      {:cors_plug, "~> 1.5"},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
