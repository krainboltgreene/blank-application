use Mix.Config

# Configure your database
config :example, Example.Database.Repo,
  username: "postgres",
  password: "password",
  database: "example_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Oban configuration
config :example, Oban,
  crontab: false,
  queues: false,
  prune: :disabled

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :example, ExampleWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
