use Mix.Config

# Configure your database
config :henosis, Henosis.Database.Repo,
  username: "postgres",
  password: "password",
  database: "henosis_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Oban configuration
config :henosis, Oban,
  crontab: false,
  queues: false,
  prune: :disabled

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :henosis, HenosisWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
