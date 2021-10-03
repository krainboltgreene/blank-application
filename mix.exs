defmodule Core.MixProject do
  @moduledoc false
  use Mix.Project

  def project do
    [
      app: :clumsy_chinchilla,
      version: "1.0.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers:
        [:phoenix, :gettext] ++ Mix.compilers() ++ [:graphql_schema_json, :graphql_schema_sdl],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: [
        production: [
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
      mod: {Core.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon, :absinthe_plug, :bamboo, :eex, :sasl]
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
      {:absinthe_phoenix, "~> 2.0.2"},
      {:absinthe_plug, "~> 1.5.8"},
      {:absinthe, "~> 1.6.5"},
      {:argon2_elixir, "~> 2.4.0"},
      {:bamboo_phoenix, "~> 1.0.0"},
      {:bamboo_smtp, "~> 4.1.0"},
      {:bamboo, "~> 2.2.0"},
      {:brains, "~> 0.1.5"},
      {:castore, "~> 0.1.11"},
      {:comeonin, "~> 5.3.2"},
      {:cors_plug, "~> 2.0.3"},
      {:coverex, "~> 1.5.0", only: :dev, runtime: false},
      {:credo, "~> 1.5.6", only: [:dev, :test], runtime: false},
      {:crudry, "~> 2.4.0"},
      {:dataloader, "~> 1.0.9"},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:distillery, "~> 2.1.1"},
      {:ecto_autoslug_field, "~> 3.0.0"},
      {:ecto_enum, "~> 1.4.0"},
      {:ecto_psql_extras, "~> 0.7.0"},
      {:ecto_sql, "~> 3.7.0"},
      {:encrypted_secrets, "~> 0.3.0"},
      {:envy, "~> 1.1.1"},
      {:exvcr, "~> 0.13.2", only: :test},
      {:flippant, "~> 2.0.0"},
      {:floki, "~> 0.31.0", only: :test},
      {:flow, "~> 1.1.0"},
      {:gen_stage, "~> 1.1.1", override: true},
      {:gettext, "~> 0.18.2"},
      {:inflex, "~> 2.1.0"},
      {:jason, "~> 1.2.2"},
      {:mix_test_watch, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:oban, "~> 2.9.2"},
      {:paper_trail, "~> 0.14.2"},
      {:phoenix_ecto, "~> 4.4.0"},
      {:phoenix_html, "~> 3.0.4"},
      {:phoenix_live_dashboard, "~> 0.5.2"},
      {:phoenix_live_reload, "~> 1.3.3", only: :dev},
      {:phoenix_live_view, "~> 0.16.4"},
      {:phoenix_pubsub, "~> 2.0.0"},
      {:phoenix, "~> 1.6.0"},
      {:plug_cowboy, "~> 2.5.1"},
      {:plug_telemetry_server_timing, "~> 0.2.0"},
      {:postgrex, "~> 0.15.10"},
      {:recase, "~> 0.7.0"},
      {:redix, "~> 1.1.4"},
      {:telemetry_metrics, "~> 0.6.1"},
      {:telemetry_poller, "~> 0.5.1"}
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
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repository/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
