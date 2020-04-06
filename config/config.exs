# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures for ecto
config :blank,
  ecto_repos: [Blank.Database.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :blank, BlankWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JGuPqitGiv1A5WgWCxBQ8E2n7qzF8ThtUA/j0N1lfZzsvRv9VToPD4gADyCdbHaI",
  render_errors: [view: BlankWeb.ErrorView, accepts: ["json"]],
  pubsub: [name: Blank.PubSub, adapter: Phoenix.PubSub.PG2]

# Configure background processor oban
config :blank, Oban,
  repo: Blank.Database.Repo,
  prune: {:maxlen, 10_000},
  queues: [default: 10, mailers: 10, events: 50, media: 2, google_places: 1]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :paper_trail,
  repo: Blank.Database.Repo,
  item_type: Ecto.UUID,
  originator_type: Ecto.UUID,
  originator: [name: :account, model: Blank.Models.Account]

config :google_maps,
  api_key: "YOUR API KEY HERE"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
