# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :clumsy_chinchilla,
  ecto_repos: [Database.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :clumsy_chinchilla, ClumsyChinchillaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QBzZwNT6wxgJZdiJ6aJVht82dDvzRFvXXLmK8RlHV888PqL/gzRQX36DlWjRjFWs",
  render_errors: [view: ClumsyChinchillaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ClumsyChinchilla.PubSub,
  live_view: [signing_salt: "bbTmf3m/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Tell Absinthe what schema to use
config :absinthe, schema: Graphql.Schema

# Setup configuration for paper_trail
config :paper_trail,
  repo: Database.Repo,
  item_type: Ecto.UUID,
  originator_type: Ecto.UUID,
  originator: [name: :account, model: Database.Models.Account]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
