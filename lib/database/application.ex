defmodule Database.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Database.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Database.PubSub}
      # Start a worker by calling: Database.Worker.start_link(arg)
      # {Database.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Database.Supervisor)
  end
end
