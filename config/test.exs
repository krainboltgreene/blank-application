use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :find_reel_love, Database.Repository,
  username: "postgres",
  password: "postgres",
  database: "find_reel_love_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :find_reel_love, Database.Repository,
    username: "postgres",
    password: "postgres"
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :find_reel_love, Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :find_reel_love, Oban, crontab: false, queues: false, plugins: false
