defmodule Core.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :core,
    adapter: Ecto.Adapters.Postgres

  require Ecto.Query

  @spec terminal_error_formatting({:error, Ecto.Changeset.t()} | {:ok, any}) ::
          :ok | String.t()
  def terminal_error_formatting({:ok, _}), do: :ok

  def terminal_error_formatting({:error, changeset}) do
    Ecto.Changeset.traverse_errors(changeset, fn
      {msg, opts} -> String.replace(msg, "%{count}", to_string(opts[:count]))
      msg -> msg
    end)
    |> Enum.map(fn {key, value} -> "#{key} #{value}" end)
    |> Core.to_sentence()
    |> prefix_error(changeset)
  end

  defp prefix_error(message, changeset) do
    "#{changeset.data.__struct__} #{message} #{changeset.changes |> inspect}"
  end

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
