defmodule Core.HTTPClient.Skin do
  @skins_url "https://raw.communitydragon.org/11.5/plugins/rcp-be-lol-game-data/global/default/v1/skins.json"

  @spec fetch :: {:ok, list(Database.Models.Skin.t)} | Core.HTTPClient.client_errors
  def fetch do
    Core.HTTPClient.fetch(:community, @skins_url)
    |> case do
      {:ok, payload} -> {:ok, payload |>  Map.values()}
      error -> error
    end
    |> case do
      {:ok, payload} -> {:ok, payload |> Enum.map(&transform/1)}
      error -> error
    end
    |> case do
      {:ok, data} -> data |> Enum.map(&Database.Models.Skin.create_or_update_by_external_id/1)
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

  defp transform(raw) do
    %{
      skinline: raw
        |> Map.get("skinLines")
        |> case do
          nil -> nil
          skinlines -> skinlines |> List.first |> Map.get("id") |> to_skinline
        end,
      chromas: raw
        |> Map.get("chromas")
        |> case do
          nil -> []
          chroma -> chroma
        end
        |> Enum.map(&transform_chroma/1) |> Enum.map(&Database.Models.Chroma.find_or_initialize_by_external_id/1),
      community_data: raw,
      external_id: raw["id"],
      name: raw["name"]
    }
  end

  defp transform_chroma(raw) do
    %{
      community_data: raw,
      external_id: raw["id"],
      name: raw["name"],
      colors: raw["colors"]
    }
  end

  defp to_skinline(external_id) do
    Database.Repository.get_by(Database.Models.Skinline, external_id: external_id)
  end
end
