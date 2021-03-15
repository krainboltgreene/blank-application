defmodule WeAllMatch.Skinline do
  @keys [:id, :name]
  @enforce_keys @keys
  defstruct @keys
  @type t() :: %__MODULE__{
    id: integer,
    name: String.t
  }
  @skinlines_url "https://raw.communitydragon.org/11.5/plugins/rcp-be-lol-game-data/global/default/v1/skinlines.json"

  @spec all :: {:ok, list(__MODULE__.t)} | WeAllMatch.client_errors
  def all do
    WeAllMatch.HTTPClient.fetch(:community, @skinlines_url)
    |> case do
      {:ok, payload} -> {:ok, payload |> Enum.map(&__MODULE__.build/1)}
      error -> error
    end
  end

  @spec build(map) :: __MODULE__.t()
  def build(raw) do
    raw
    |> Map.new(fn
      {k, v} -> {String.to_atom(k), v}
    end)
    |> Map.take(@keys)
    |> __MODULE__.__struct__()
  end
end
