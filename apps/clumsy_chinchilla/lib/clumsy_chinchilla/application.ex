defmodule ClumsyChinchilla.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    unless Mix.env() == :prod do
      Envy.auto_load()
    end

    children = [
      # Start the Ecto repository
      ClumsyChinchilla.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ClumsyChinchilla.PubSub},
      # Start a worker by calling: ClumsyChinchilla.Worker.start_link(arg)
      # {ClumsyChinchilla.Worker, arg}
      {Absinthe.Subscription, ClumsyChinchillaWeb.Endpoint}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ClumsyChinchilla.Supervisor)
  end
end
