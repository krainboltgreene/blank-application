use Mix.Config

Application.put_env(:weallmatch, :domain, "localhost")
Application.put_env(:weallmatch, :base_url, "/")

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :weallmatch, Database.Repository,
  username: "postgres",
  password: "postgres",
  database: "weallmatch_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :weallmatch, Database.Repository,
    username: "postgres",
    password: "postgres"
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :weallmatch, Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :weallmatch, Oban, crontab: false, queues: false, plugins: false
