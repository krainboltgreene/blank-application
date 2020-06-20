defmodule Henosis.Application do
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
      Henosis.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Henosis.PubSub},
      # Start a worker by calling: Henosis.Worker.start_link(arg)
      # {Henosis.Worker, arg}
      {Absinthe.Subscription, HenosisWeb.Endpoint}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Henosis.Supervisor)
  end
end
