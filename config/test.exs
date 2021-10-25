use Mix.Config

Application.put_env(:card_game, :domain, "localhost")
Application.put_env(:card_game, :base_url, "/")

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :card_game, Database.Repository,
  username: "postgres",
  password: "postgres",
  database: "clumsy_chinchilla_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :card_game, Database.Repository,
    username: "postgres",
    password: "postgres"
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :card_game, Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :card_game, Oban, crontab: false, queues: false, plugins: false
