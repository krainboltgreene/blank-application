# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config
import IO

Application.put_env(:weallmatch, :secret_key_base, System.get_env("SECRET_KEY_BASE"))
Application.put_env(:weallmatch, :signing_salt, System.get_env("SIGNING_SALT"))
Application.put_env(:weallmatch, :application_name, "We All Match")
Application.put_env(:weallmatch, :support_email_address, "support@we-all-match.club")
Application.put_env(:weallmatch, :reply_email_address, "no-reply@we-all-match.club")

config :weallmatch,
  ecto_repos: [Database.Repository],
  generators: [binary_id: true]

# Configures the endpoint
config :weallmatch, Web.Endpoint,
  url: [host: Application.get_env(:weallmatch, :domain)],
  secret_key_base: Application.get_env(:weallmatch, :secret_key_base),
  render_errors: [view: Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Core.PubSub,
  live_view: [signing_salt: Application.get_env(:weallmatch, :signing_salt)]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Tell Absinthe what schema to use
config :absinthe, schema: Graphql.Schema

config :logger, :console,
  format: "[$level] #{IO.ANSI.bright()}$message#{IO.ANSI.normal()} $metadata[$level]\n",
  metadata: :all,
  color: :enabled

# Setup configuration for paper_trail
config :paper_trail,
  repo: Database.Repository,
  item_type: Ecto.UUID,
  originator_type: Ecto.UUID,
  originator: [name: :account, model: Database.Models.Account]

config :weallmatch, Oban,
  repo: Database.Repository,
  plugins: [
    Oban.Plugins.Pruner
  ],
  queues: [
    default: 10,
    mailers: 20,
    media: 20,
    events: 50,
  ]

config :weallmatch, :browser_metadata, %{
  domain: Application.get_env(:weallmatch, :domain),
  application_name: Application.get_env(:weallmatch, :application_name),
  base_url: Application.get_env(:weallmatch, :base_url),
  theme_color: "#ffffff",
  description: "A website",
  google_site_verification: "",
  short_description: "A website",
  title: Application.get_env(:weallmatch, :application_name),
  google_tag_manager_id: "",
  support_email_address: Application.get_env(:weallmatch, :support_email_address)
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config("#{Mix.env()}.exs")
