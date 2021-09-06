use Mix.Config

# Configure your database
config :clumsy_chinchilla, Database.Repository,
  username: "postgres",
  password: "postgres",
  database: "clumsy_chinchilla_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  prepare: :unnamed

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :clumsy_chinchilla, Database.Repository,
    username: "postgres",
    password: "postgres"
end


config :logger,
  backends: [:console]

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :clumsy_chinchilla, Web.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    # node: [
    #   "node_modules/webpack/bin/webpack.js",
    #   "--mode",
    #   "development",
    #   "--watch-stdin",
    #   cd: Path.expand("../assets", __DIR__)
    # ]
  ]


# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :clumsy_chinchilla, Web.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/web/(live|views)/.*(ex)$",
      ~r"lib/web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :clumsy_chinchilla, :graphql, uri: "http://localhost:4000/graphql"

config :clumsy_chinchilla, :flow, max_demand: 8

# Setup Bamboo mailer
config :clumsy_chinchilla, Mailer,
  adapter: Bamboo.LocalAdapter

unless System.get_env("GITHUB_ACTIONS") || System.get_env("CODESPACES") do
  config :clumsy_chinchilla, Mailer,
    open_email_in_browser_url: "http://localhost:4000/sent_emails"
end
