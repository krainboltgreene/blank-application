defmodule Henosis.Repo do
  use Ecto.Repo,
    otp_app: :henosis,
    adapter: Ecto.Adapters.Postgres
end
