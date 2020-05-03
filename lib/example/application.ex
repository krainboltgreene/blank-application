defmodule Example.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    unless Mix.env() == :prod do
      Envy.auto_load()
    end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    Supervisor.start_link(
      [
        # Start the Ecto repository
        Example.Database.Repo,
        # Start the endpoint when the application starts
        ExampleWeb.Endpoint,
        # Starts a worker by calling: Example.Worker.start_link(arg)
        # {Example.Worker, arg},
        {Absinthe.Subscription, [ExampleWeb.Endpoint]}
      ],
      strategy: :one_for_one,
      name: Example.Supervisor
    )
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @spec config_change(any, any, any) :: :ok
  def config_change(changed, _new, removed) do
    ExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
