defmodule Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :core,
      version: "1.0.0",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers() ++ [:surface],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [plt_add_apps: [:mix, :logger, :eex]]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Core.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
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
      {:bcrypt_elixir, "~> 3.0"},
      {:brains, "~> 0.1.5"},
      {:castore, "~> 0.1.11"},
      {:cors_plug, "~> 2.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ecto_autoslug_field, "~> 3.0"},
      {:ecto_enum, "~> 1.4"},
      {:ecto_psql_extras, "~> 0.7.0"},
      {:ecto_sql, "~> 3.7"},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:flippant, "~> 2.0"},
      {:floki, "~> 0.32.0", only: :test},
      {:gettext, "~> 0.19.1"},
      {:heex_formatter, github: "feliperenan/heex_formatter"},
      {:inflex, "~> 2.1"},
      {:mix_test_watch, "~> 1.1", only: [:dev, :test], runtime: false},
      {:oban, "~> 2.11"},
      {:paper_trail, "~> 0.14.2"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.2"},
      {:phoenix_live_dashboard, "~> 0.6.4"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:phoenix, "~> 1.6"},
      {:plug_cowboy, "~> 2.5"},
      {:plug_telemetry_server_timing, "~> 0.3.0"},
      {:postgrex, "~> 0.16"},
      {:recase, "~> 0.7.0"},
      {:redix, "~> 1.1"},
      {:surface_catalogue, "~> 0.3.0"},
      {:surface, "~> 0.7.0"},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6.0"},
      {:telemetry_poller, "~> 1.0"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}

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
      check: [
        "compile",
        "ecto.drop --quiet",
        "ecto.create --quiet",
        "ecto.migrate --quiet",
        "credo",
        "dialyzer --quiet"
      ],
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs --quiet"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: [
        "ecto.drop --quiet",
        "ecto.create --quiet",
        "ecto.migrate --quiet",
        "run priv/repo/seeds.exs",
        "test"
      ],
      "assets.deploy": ["esbuild default --minify", "phx.digest"]
    ]
  end
end
