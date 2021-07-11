defmodule Core.Matcher do
  # import Ecto.Query, only: [from: 2]
  @type position :: :top | :bottom | :support | :jungle | :mid
  @type player_id :: String.t
  @type champion_id :: String.t

  @spec run(list(list)) :: list(list)
  def run(possibilities) do
    possibilities
    |> Enum.flat_map(&find_champions/1)
    |> Enum.map(&preload_relationships/1)
    |> Enum.flat_map(&find_skins/1)
  end

  def find_champions({player, champion_ids}) do
    champion_ids
    |> Enum.map(fn champion_id ->
      {
        player,
        Database.Repository.get_by(
          Database.Models.Champion,
          external_id: champion_id
        )
      }
    end)
  end

  def preload_relationships({player, champion}) do
    {
      player,
      champion |> Database.Repository.preload([skins: [[skinline: :universe], :chromas]])
    }
  end

  def find_skins({player, champion}) do
    champion.skins
    |> Enum.map(fn skin -> {player, champion, skin} end)
  end
end
