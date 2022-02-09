defmodule ClumsyChinchilla.MixProject do
  use Mix.Project

  def project do
    [
      app: :clumsy_chinchilla,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
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
      mod: {ClumsyChinchilla.Application, []},
      extra_applications: [:logger, :runtime_tools]
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
      {:bcrypt_elixir, "~> 2.0"},
      {:argon2_elixir, "~> 3.0.0"},
      {:brains, "~> 0.1.5"},
      {:castore, "~> 0.1.11"},
      {:comeonin, "~> 5.3.2"},
      {:cors_plug, "~> 2.0.3"},
      {:coverex, "~> 1.5.0", only: :dev, runtime: false},
      {:credo, "~> 1.6.3", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:ecto_autoslug_field, "~> 3.0.0"},
      {:ecto_enum, "~> 1.4.0"},
      {:ecto_psql_extras, "~> 0.7.0"},
      {:ecto_sql, "~> 3.7.0"},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:flippant, "~> 2.0.0"},
      {:floki, "~> 0.32.0", only: :test},
      {:gettext, "~> 0.19.1"},
      {:inflex, "~> 2.1.0"},
      {:jason, "~> 1.3.0"},
      {:mix_test_watch, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:oban, "~> 2.10.1"},
      {:paper_trail, "~> 0.14.2"},
      {:phoenix_ecto, "~> 4.4.0"},
      {:phoenix_html, "~> 3.2.0"},
      {:phoenix_live_dashboard, "~> 0.6.4"},
      {:phoenix_live_reload, "~> 1.3.3", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:phoenix_pubsub, "~> 2.0.0"},
      {:phoenix, "~> 1.6.6"},
      {:plug_cowboy, "~> 2.5.1"},
      {:plug_telemetry_server_timing, "~> 0.3.0"},
      {:postgrex, "~> 0.16.1"},
      {:recase, "~> 0.7.0"},
      {:redix, "~> 1.1.4"},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6.1"},
      {:telemetry_poller, "~> 1.0.0"}
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
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["esbuild default --minify", "phx.digest"]
    ]
  end
end
