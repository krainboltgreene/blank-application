defmodule ClumsyChinchilla.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ClumsyChinchilla.Repo,
      # Start the Telemetry supervisor
      ClumsyChinchillaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ClumsyChinchilla.PubSub},
      # Start the Endpoint (http/https)
      ClumsyChinchillaWeb.Endpoint,
      # Start the background job
      {Oban, Application.get_env(:clumsy_chinchilla, Oban)},
      ClumsyChinchillaWeb.Presence
      # Start a worker by calling: ClumsyChinchilla.Worker.start_link(arg)
      # {ClumsyChinchilla.Worker, arg}
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
    opts = [strategy: :one_for_one, name: ClumsyChinchilla.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ClumsyChinchillaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end