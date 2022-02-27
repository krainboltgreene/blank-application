defmodule Core.Repo do
  use Ecto.Repo,
    otp_app: :core,
    adapter: Ecto.Adapters.Postgres

  require Ecto.Query

  @spec pluck(atom | Ecto.Query.t(), atom | list(atom)) :: list(any)
  def pluck(model_or_query, field)
      when is_atom(model_or_query) or (is_struct(model_or_query) and is_atom(field)) do
    model_or_query
    |> Ecto.Query.select(^[field])
    |> Core.Repo.all()
    |> Enum.map(&Map.get(&1, field))
  end

  def pluck(model_or_query, fields)
      when is_atom(model_or_query) or (is_struct(model_or_query) and is_list(fields)) do
    model_or_query
    |> Ecto.Query.select(^fields)
    |> Core.Repo.all()
    |> Enum.map(fn record -> Map.values(Map.take(record, fields)) end)
  end
end
