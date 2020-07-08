defmodule Database.Repo do
  use Ecto.Repo,
    otp_app: :clumsy_chinchilla,
    adapter: Ecto.Adapters.Postgres
end
