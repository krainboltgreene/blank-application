defmodule WeAllMatch.Champion.Skin.Chroma do
  @keys [:id, :colors]
  @enforce_keys @keys
  defstruct @enforce_keys
  @type t() :: %__MODULE__{
    id: integer,
    colors: list(String.t)
  }

  @spec build(map) :: __MODULE__.t()
  def build(raw) do
    raw
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
    |> Map.take(@keys)
    |> __MODULE__.__struct__()
  end
end
