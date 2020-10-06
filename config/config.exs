# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config
import IO

config :clumsy_chinchilla,
  ecto_repos: [Database.Repository],
  generators: [binary_id: true]

# Configures the endpoint
config :clumsy_chinchilla, ClumsyChinchillaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QBzZwNT6wxgJZdiJ6aJVht82dDvzRFvXXLmK8RlHV888PqL/gzRQX36DlWjRjFWs",
  render_errors: [view: ClumsyChinchillaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ClumsyChinchilla.PubSub,
  live_view: [signing_salt: "bbTmf3m/"]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Tell Absinthe what schema to use
config :absinthe, schema: Graphql.Schema

config :logger, :console,
  format: "[$level] #{IO.ANSI.bright()}$message#{IO.ANSI.normal()} $metadata[$level]\n",
  metadata: :all,
  color: :enabled

config :logger, :logs,
  path: "tmp/application.log",
  metadata: :all,
  format: "[$date][$time][$node][$level] #{IO.ANSI.bright()}$message#{IO.ANSI.normal()} $metadata\n"

# Setup configuration for paper_trail
config :paper_trail,
  repo: Database.Repository,
  item_type: Ecto.UUID,
  originator_type: Ecto.UUID,
  originator: [name: :account, model: Database.Models.Account]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config("#{Mix.env()}.exs")
