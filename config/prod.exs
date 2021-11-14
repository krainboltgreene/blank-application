use Mix.Config

Application.put_env(:find_reel_love, :domain, "www.findreel.love")
Application.put_env(:find_reel_love, :base_url, "https://www.findreel.love")

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :find_reel_love, Web.Endpoint,
  url: [host: Application.get_env(:find_reel_love, :domain), port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :find_reel_love, Web.Endpoint,
#       ...
#       url: [host: Application.get_env(:find_reel_love, :domain), port: 443],
#       https: [
#         port: 443,
#         cipher_suite: :strong,
#         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#         certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#         transport_options: [socket_opts: [:inet6]]
#       ]
#
# The `cipher_suite` is set to `:strong` to support only the
# latest and more secure SSL ciphers. This means old browsers
# and clients may not be supported. You can set it to
# `:compatible` for wider support.
#
# `:keyfile` and `:certfile` expect an absolute path to the key
# and cert in disk or a relative path inside priv, for example
# "priv/ssl/server.key". For all supported SSL configuration
# options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
#
# We also recommend setting `force_ssl` in your endpoint, ensuring
# no data is ever sent via http, always redirecting to https:
#
config :find_reel_love, Web.Endpoint,
  force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

config :find_reel_love, Database.Repository,
  database: "find_reel_love",
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "10")),
  prepare: :unnamed

config :find_reel_love, Web.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT", "4000")),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: Application.get_env(:find_reel_love, :secret_key_base)

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :find_reel_love, Web.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
