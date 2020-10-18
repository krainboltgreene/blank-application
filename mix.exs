defmodule ClumsyChinchilla.MixProject do
  use Mix.Project

  def project do
    [
      app: :clumsy_chinchilla,
      version: "1.0.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: [
        clumsy_chinchilla_production: [
          include_erts: true,
          include_executables_for: [:unix],
          applications: [
            runtime_tools: :permanent
          ]
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ClumsyChinchilla.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon, :absinthe_plug]
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
      {:absinthe_phoenix, "~> 2.0"},
      {:absinthe_plug, "~> 1.5"},
      {:absinthe, "~> 1.5"},
      {:argon2_elixir, "~> 2.1"},
      {:brains, "~> 0.1"},
      {:castore, "~> 0.1"},
      {:comeonin, "~> 5.2"},
      {:cors_plug, "~> 2.0"},
      {:coverex, "~> 1.5", only: :dev, runtime: false},
      {:crudry, "~> 2.3"},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dataloader, "~> 1.0"},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false},
      {:distillery, "~> 2.1"},
      {:ecto_autoslug_field, "~> 2.0"},
      {:ecto_enum, "~> 1.4"},
      {:ecto_sql, "~> 3.4"},
      {:envy, "~> 1.1"},
      {:exvcr, "~> 0.11", only: :test},
      {:flippant, "~> 1.0"},
      {:floki, "~> 0.26", only: :test},
      {:flow, "~> 1.0"},
      {:gen_stage, "~> 1.0", override: true},
      {:gettext, "~> 0.18"},
      {:inflex, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:paper_trail, "~> 0.8"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_html, "~> 2.11"},
      {:ecto_psql_extras, "~> 0.2"},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.13"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix, "~> 1.5"},
      {:plug_cowboy, "~> 2.3"},
      {:postgrex, "~> 0.15"},
      {:recase, "~> 0.6"},
      {:redix, "~> 0.11"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
