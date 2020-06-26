defmodule Graphql.MixProject do
  use Mix.Project

  def project do
    [
      app: :graphql,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:absinthe, "~> 1.5"},
      {:absinthe_phoenix, "~> 2.0"},
      {:absinthe_error_payload, "~> 1.0"},
      {:dataloader, "~> 1.0"},
      {:clumsy_chinchilla, in_umbrella: true},
      {:database, in_umbrella: true}
    ]
  end
end
