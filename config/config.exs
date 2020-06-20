# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :database,
  ecto_repos: [Database.Repo]

# Configure Mix tasks and generators
config :henosis,
  ecto_repos: [Database.Repo]

config :henosis_web,
  ecto_repos: [Database.Repo],
  generators: [context_app: :henosis, binary_id: true]

# Configures the endpoint
config :henosis_web, HenosisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5VNIbfli/JkHqzWzyFkeMKZw0RKORlHo62lCIYm0YJWmei7Awkv5yMriLTl9PJI6",
  render_errors: [view: HenosisWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Henosis.PubSub,
  live_view: [signing_salt: "ImpUMv5Z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Tell Absinthe what schema to use
config :absinthe, schema: HenosisWeb.Graphql.Schema

# Setup configuration for paper_trail
config :paper_trail,
  repo: Database.Repo,
  item_type: Ecto.UUID,
  originator_type: Ecto.UUID,
  originator: [name: :account, model: Database.Models.Account]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
