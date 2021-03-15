defmodule WeAllMatch.Champion.Skin do
  @keys [:id, :name, :chromas, :index, :skinline]
  @enforce_keys @keys
  defstruct @enforce_keys
  @type t() :: %__MODULE__{
    id: String.t(),
    name: String.t,
    index: integer,
    chromas: true | false | list(__MODULE__.Chroma.t),
    skinline: nil | String.t
  }
  @skins_url "https://raw.communitydragon.org/11.5/plugins/rcp-be-lol-game-data/global/default/v1/skins.json"
  @skin_url "http://ddragon.leagueoflegends.com/cdn/img/champion/loading"

  @spec build(map) :: __MODULE__.t()
  def build(raw) do
    raw
    |> complete
    |> Map.new(fn
      {"skinLines", nil} -> {:skinline, nil}
      {"skinLines", skinline} -> {:skinline, skinline |> List.first |> Map.get("id")}
      {"chromas", true} -> {:chromas, true}
      {"chromas", false} -> {:chromas, false}
      {"chromas", chromas} -> {:chromas, chromas |> Enum.map(&__MODULE__.Chroma.build/1)}
      {k, v} -> {String.to_atom(k), v}
    end)
    |> Map.take(@keys)
    |> __MODULE__.__struct__()
  end

  @spec uri(integer, String.t) :: String.t
  def uri(index, champion_id) do
    "#{@skin_url}/#{champion_id}_#{index}.jpg"
  end

  defp complete(mapping) do
    retrieve_community_data()
    |> case do
      {:ok, payload} -> {:ok, Map.get(payload, mapping["id"], %{})}
      error -> error
    end
    |> case do
      {:ok, champion} -> Map.merge(mapping, champion)
      error -> error
    end
  end

  defp retrieve_community_data do
    WeAllMatch.HTTPClient.fetch(:community, @skins_url)
  end
end
