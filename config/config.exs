# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

Application.put_env(:core, :secret_key_base, System.get_env("SECRET_KEY_BASE"))
Application.put_env(:core, :signing_salt, System.get_env("SIGNING_SALT"))
Application.put_env(:core, :application_name, "Clumsy Chinchilla")
Application.put_env(:core, :support_email_address, "support@clumsy-chinchilla.club")
Application.put_env(:core, :reply_email_address, "no-reply@clumsy-chinchilla.club")

config :core,
  ecto_repos: [Database.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :core, CoreWeb.Endpoint,
  url: [host: Application.get_env(:core, :domain)],
  secret_key_base: Application.get_env(:core, :secret_key_base),
  render_errors: [view: CoreWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Core.PubSub,
  live_view: [signing_salt: Application.get_env(:core, :signing_salt)]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :core, Core.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
# config :esbuild,
#   version: "0.12.18",
#   default: [
#     args:
#       ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
#     cd: Path.expand("../assets", __DIR__),
#     env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
#   ]

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :logger, :console,
  format: "[$level] #{IO.ANSI.bright()}$message#{IO.ANSI.normal()} $metadata[$level]\n",
  metadata: :all,
  color: :enabled

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Setup configuration for paper_trail
config :paper_trail,
  repo: Database.Repo,
  item_type: Ecto.UUID,
  originator_type: Ecto.UUID,
  originator: [name: :account, model: Database.Models.Account]

config :core, Oban,
  repo: Database.Repo,
  plugins: [
    Oban.Plugins.Pruner
  ],
  queues: [
    default: 10,
    mailers: 20,
    media: 20,
    events: 50,
  ]

config :core, :browser_metadata, %{
  domain: Application.get_env(:core, :domain),
  application_name: Application.get_env(:core, :application_name),
  base_url: Application.get_env(:core, :base_url),
  theme_color: "#ffffff",
  description: "A website",
  google_site_verification: "",
  short_description: "A website",
  title: Application.get_env(:core, :application_name),
  google_tag_manager_id: "",
  support_email_address: Application.get_env(:core, :support_email_address)
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config("#{Mix.env()}.exs")
