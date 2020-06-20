defmodule Henosis.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "1.0.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      apps: [:database, :henosis, :henosis_web],
      aliases: aliases()
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps/ folder.
  defp deps do
    [
      {:phoenix, "~> 1.5"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_pubsub, "~> 2.0"},
      {:cors_plug, "~> 2.0"},
      {:plug_cowboy, "~> 2.3"},
      {:gettext, "~> 0.18"},

      {:postgrex, "~> 0.15"},
      {:ecto_sql, "~> 3.4"},
      {:ecto_autoslug_field, "~> 2.0"},
      {:ecto_enum, "~> 1.4"},
      {:argon2_elixir, "~> 2.1"},

      {:absinthe, "~> 1.5"},
      {:absinthe_phoenix, "~> 2.0"},
      {:absinthe_plug, "~> 1.5"},
      {:absinthe_error_payload, "~> 1.0"},
      {:dataloader, "~> 1.0"},

      {:jason, "~> 1.0"},
      {:comeonin, "~> 5.2"},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false},
      {:envy, "~> 1.1"},
      {:flippant, "~> 1.0"},
      {:machinery, "~> 1.0"},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:paper_trail, "~> 0.8"},
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
  #
  # Aliases listed here are available only for this project
  # and cannot be accessed from applications inside the apps/ folder.
  defp aliases do
    [
      # run `mix setup` in all child apps
      setup: ["cmd mix setup"]
    ]
  end
end
