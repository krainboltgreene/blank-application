import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :clumsy_chinchilla, ClumsyChinchilla.Repo,
  username: "postgres",
  password: if(System.get_env("CI"), do: "postgres"),
  hostname: "localhost",
  database: "clumsy_chinchilla_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :clumsy_chinchilla, ClumsyChinchillaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "cP5HarqKBgXZ7vgMzlyjzkf1rqOUkndqwDZheU5a3c1rcJITm07w94AKHJb36w2/",
  server: false

# In test we don't send emails.
config :clumsy_chinchilla, ClumsyChinchilla.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :clumsy_chinchilla, Oban, queues: false, plugins: false
