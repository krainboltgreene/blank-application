# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :plotgenerator,
  application_name: "Clumsy Chinchilla",
  support_email_address: "support@clumsy-chinchilla.club",
  theme_color: "#ffffff",
  description: "A website",
  short_description: "A website",
  google_site_verification: "",
  google_tag_manager_id: ""

config :clumsy_chinchilla,
  ecto_repos: [ClumsyChinchilla.Repo],
  generators: [binary_id: true]

config :clumsy_chinchilla,
       ClumsyChinchilla.Repo,
       migration_primary_key: [name: :id, type: :binary_id],
       migration_foreign_key: [column: :id, type: :binary_id]

# Configures the endpoint
config :clumsy_chinchilla, ClumsyChinchillaWeb.Endpoint,
  url: [host: Application.get_env(:clumsy_chinchilla, :domain)],
  render_errors: [view: ClumsyChinchillaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ClumsyChinchilla.PubSub,
  live_view: [signing_salt: Application.get_env(:clumsy_chinchilla, :signing_salt)]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :clumsy_chinchilla, ClumsyChinchilla.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
import IO

config :logger, :console,
  format: "[$level] #{IO.ANSI.bright()}$message#{IO.ANSI.normal()} $metadata[$level]\n",
  metadata: :all,
  color: :enabled

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Setup configuration for paper_trail
config :paper_trail,
  repo: ClumsyChinchilla.Repo,
  item_type: Ecto.UUID,
  originator_type: Ecto.UUID,
  originator: [name: :account, model: ClumsyChinchilla.Users.Account]

config :clumsy_chinchilla, Oban,
  repo: ClumsyChinchilla.Repo,
  plugins: [
    Oban.Plugins.Pruner
  ],
  queues: [
    default: 10,
    mailers: 20,
    media: 20,
    events: 50
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
