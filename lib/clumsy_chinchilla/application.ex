defmodule ClumsyChinchilla.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Database.Repo,
      # Start the Telemetry supervisor
      ClumsyChinchillaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ClumsyChinchilla.PubSub},
      # Start the Endpoint (http/https)
      ClumsyChinchillaWeb.Endpoint,
      {Absinthe.Subscription, ClumsyChinchillaWeb.Endpoint}
      # Start a worker by calling: ClumsyChinchilla.Worker.start_link(arg)
      # {ClumsyChinchilla.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClumsyChinchilla.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ClumsyChinchillaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end