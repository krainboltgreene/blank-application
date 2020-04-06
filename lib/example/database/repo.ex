defmodule Example.Database.Repo do
  use Ecto.Repo,
    otp_app: :example,
    adapter: Ecto.Adapters.Postgres
end
