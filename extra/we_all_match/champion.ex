defmodule WeAllMatch.Champion do
  @keys [:id, :skins]
  @enforce_keys @keys
  defstruct @keys
  @type t() :: %__MODULE__{
    id: String.t,
    skins: list( __MODULE__.Skin.t())
  }
  @champions_url "http://ddragon.leagueoflegends.com/cdn/11.5.1/data/en_US/champion.json"
  @champion_url "http://ddragon.leagueoflegends.com/cdn/11.5.1/data/en_US/champion"

  @spec all :: {:ok, list(__MODULE__.t)} | WeAllMatch.client_errors
  def all do
    WeAllMatch.HTTPClient.fetch(:league, @champions_url)
    |> case do
      {:ok, payload} -> {:ok, Map.get(payload, "data", %{})}
      error -> error
    end
    |> case do
      {:ok, data} -> {:ok, Map.values(data)}
      error -> error
    end
    |> case do
      {:ok, champions} -> {:ok, champions |> Enum.map(&__MODULE__.build/1)}
      error -> error
    end
  end

  @spec build(map) :: __MODULE__.t()
  def build(raw) do
    raw
    |> complete
    |> Map.new(fn
      {"skins", v} -> {:skins,
        v
        |> Enum.with_index()
        |> Enum.map(fn {data, index} -> Map.merge(data, %{"index" => index}) end)
        |> Enum.map(&__MODULE__.Skin.build/1)
      }
      {k, v} -> {String.to_atom(k), v}
    end)
    |> Map.take(@keys)
    |> __MODULE__.__struct__()
  end

  defp complete(mapping) do
    retrieve_league_data(mapping["id"])
    |> case do
      {:ok, payload} -> {:ok, Map.get(payload, "data")}
      error -> error
    end
    |> case do
      {:ok, data} -> {:ok, Map.get(data, mapping["id"])}
      error -> error
    end
    |> case do
      {:ok, champion} -> Map.merge(mapping, champion)
      error -> error
    end
  end

  defp retrieve_league_data(id) do
    WeAllMatch.HTTPClient.fetch(:league, "#{@champion_url}/#{id}.json")
  end
end
