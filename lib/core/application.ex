defmodule Core.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Database.Repo,
      # Start the Telemetry supervisor
      Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Core.PubSub},
      # Start the Endpoint (http/https)
      Web.Endpoint,
      # Start a worker by calling: Core.Worker.start_link(arg)
      # {Core.Worker, arg}
      Web.Presence,
      {Absinthe.Subscription, Web.Endpoint},
      {Oban, Application.get_env(:clumsy_chinchilla, Oban)}
    ]

    Plug.Telemetry.ServerTiming.install([
      {[:phoenix, :endpoint, :stop], :duration},
      {[:phoenix, :router_dispatch, :stop], :duration},
      {[:phoenix, :live_view, :mount], :duration},
      {[:database, :repository, :query], :total_time},
      {[:database, :repository, :query], :decode_time},
      {[:database, :repository, :query], :query_time},
      {[:database, :repository, :query], :queue_time},
      {[:database, :repository, :query], :idle_time},
      {[:absinthe, :execute, :operation, :stop], :duration},
      {[:absinthe, :subscription, :publish, :stop], :duration},
      {[:absinthe, :resolve, :field, :stop], :duration},
      {[:absinthe, :middleware, :batch, :stop], :duration}
    ])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
