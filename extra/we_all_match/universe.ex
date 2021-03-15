defmodule WeAllMatch.Universe do
  @keys [:id, :name, :skinlines]
  @enforce_keys @keys
  defstruct @keys
  @type t() :: %__MODULE__{
    id: integer,
    name: String.t,
    skinlines: list(WeAllMatch.Skinline.t)
  }
  @universes_url "https://raw.communitydragon.org/11.5/plugins/rcp-be-lol-game-data/global/default/v1/universes.json"

  @spec all :: {:ok, list(__MODULE__.t)} | WeAllMatch.client_errors
  def all do
    WeAllMatch.HTTPClient.fetch(:community, @universes_url)
    |> case do
      {:ok, payload} -> {:ok, payload |> Enum.map(&__MODULE__.build/1)}
      error -> error
    end
  end

  @spec build(map) :: __MODULE__.t()
  def build(raw) do
    raw
    |> Map.new(fn
      {"skinSets", v} -> {:skinlines, v |> Enum.map(&WeAllMatch.Skinline.build/1)}
      {k, v} -> {String.to_atom(k), v}
    end)
    |> Map.take(@keys)
    |> __MODULE__.__struct__()
  end
end
