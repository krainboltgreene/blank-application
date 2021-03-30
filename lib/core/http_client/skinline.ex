defmodule Core.HTTPClient.Skinline do
  @skinlines_url "https://raw.communitydragon.org/11.5/plugins/rcp-be-lol-game-data/global/default/v1/skinlines.json"

  @spec fetch :: {:ok, list(Database.Models.Skinline.t)} | Core.HTTPClient.client_errors
  def fetch do
    Core.HTTPClient.fetch(:community, @skinlines_url)
    |> case do
      {:ok, payload} -> {:ok, payload |> Enum.map(&transform/1)}
      error -> error
    end
    |> case do
      {:ok, data} -> data |> Enum.map(&Database.Models.Skinline.create_or_update_by_external_id/1)
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
      community_data: raw,
      external_id: raw["id"],
      name: raw["name"]
    }
  end
end
