defmodule Core.HTTPClient.Champion do
  @champions_url "http://ddragon.leagueoflegends.com/cdn/11.5.1/data/en_US/champion.json"
  @champion_url "http://ddragon.leagueoflegends.com/cdn/11.5.1/data/en_US/champion"

  @spec fetch :: {:ok, list(Database.Models.Champion.t)} | Core.HTTPClient.client_errors
  def fetch do
    Core.HTTPClient.fetch(:league, @champions_url)
    |> case do
      {:ok, payload} -> {:ok, payload |> Map.get("data") |> Map.values()}
      error -> error
    end
    |> case do
      {:ok, partial} -> {:ok, partial |> Enum.map(&with_complete_data/1)}
      error -> error
    end
    |> case do
      {:ok, payload} -> {:ok, payload |> Enum.map(&transform/1)}
      error -> error
    end
    |> case do
      {:ok, data} -> data |> Enum.map(&Database.Models.Champion.create_or_update_by_external_id/1)
      error -> error
    end
    |> case do
      record when is_list(record) -> record |> Enum.split_with(fn
        {:ok, _} -> true
        {:error, _} -> false
      end)
      error -> error
    end
  end

  defp with_complete_data(partial) do
    Core.HTTPClient.fetch(:league, "#{@champion_url}/#{partial["id"]}.json")
    |> case do
      {:ok, payload} -> {:ok, payload |> Map.get("data")}
      error -> error
    end
    |> case do
      {:ok, data} -> {:ok, data |> Map.get(partial["id"])}
      error -> error
    end
    |> case do
      {:ok, champion} -> partial |> Map.merge(champion)
      error -> error
    end
  end

  defp transform(raw) do
    %{
      league_data: raw,
      external_id: raw["id"],
      name: raw["name"],
      skins: raw["skins"] |> Enum.map(&transform_skin/1) |> Enum.map(&Database.Models.Skin.find_or_initialize_by_external_id/1)
    }
  end

  defp transform_skin(raw) do
    %{
      league_data: raw,
      external_id: raw["id"],
      position: raw["num"],
      name: raw["name"],
      chromas: []
    }
  end
end
