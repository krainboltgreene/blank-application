defmodule WeAllMatchTest do
  use ExUnit.Case
  doctest WeAllMatch

  @universe %{}
  @chroma %WeAllMatch.Champion.Skin.Chroma{colors: ["#27211C", "#27211C"], id: 266004}
  @skinline %WeAllMatch.Skinline{id: 143, name: "Bees!"}
  @skin %WeAllMatch.Champion.Skin{id: 266000, index: 0, name: "Aatrox", chromas: false, skinline: nil}
  @champion %WeAllMatch.Champion{id: "Aatrox", skins: [
    @skin,
    %WeAllMatch.Champion.Skin{chromas: false, id: 266001, index: 1, name: "Justicar Aatrox", skinline: 33},
    %WeAllMatch.Champion.Skin{chromas: [%WeAllMatch.Champion.Skin.Chroma{colors: ["#27211C", "#27211C"], id: 266004}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#ECF9F8", "#ECF9F8"], id: 266005}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#54209B", "#54209B"], id: 266006}], id: 266002, index: 2, name: "Mecha Aatrox", skinline: 35},
    %WeAllMatch.Champion.Skin{chromas: false, id: 266003, index: 3, name: "Sea Hunter Aatrox", skinline: 49},
    %WeAllMatch.Champion.Skin{chromas: false, id: 266007, index: 4, name: "Blood Moon Aatrox", skinline: 12},
    %WeAllMatch.Champion.Skin{chromas: false, id: 266008, index: 5, name: "Blood Moon Aatrox Prestige Edition", skinline: 12},
    %WeAllMatch.Champion.Skin{chromas: [%WeAllMatch.Champion.Skin.Chroma{colors: ["#FF2C25", "#FF2C25"], id: 266010}], id: 266009, index: 6, name: "Victorious Aatrox", skinline: 7},
    %WeAllMatch.Champion.Skin{chromas: [%WeAllMatch.Champion.Skin.Chroma{colors: ["#D33528", "#D33528"], id: 266012}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#DF9117", "#DF9117"], id: 266013}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#73BFBE", "#73BFBE"], id: 266014}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#2756CE", "#2756CE"], id: 266015}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#2DA130", "#2DA130"], id: 266016}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#E58BA5", "#E58BA5"], id: 266017}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#C1F2FF", "#C1F2FF"], id: 266018}, %WeAllMatch.Champion.Skin.Chroma{colors: ["#0C0C0F", "#9B1520"], id: 266019}], id: 266011, index: 7, name: "Odyssey Aatrox", skinline: 73}
  ]}

  test "WeAllMatch.Universe.all()" do
    assert WeAllMatch.Universe.all() == {:ok, [@universe]}
  end

  test "WeAllMatch.Skinline.all()" do
    assert WeAllMatch.Skinline.all() == {:ok, [@skinline]}
  end

  test "WeAllMatch.Champion.all()" do
    assert WeAllMatch.Champion.all() == {:ok, [@champion]}
  end

  test "WeAllMatch.Skinline.build()" do
    assert WeAllMatch.Skinline.build(%{"id" => 143, "name" => "Bees!"}) == @skinline
  end

  test "WeAllMatch.Champion.build()" do
    assert WeAllMatch.Champion.build(%{"id" => "Aatrox"}) == @champion
  end

  test "WeAllMatch.Champion.Skin.build()" do
    assert WeAllMatch.Champion.Skin.build(%{"index" => 0, "name" => "Aatrox", "chromas" => false, "id" => 266000, "skinLines" => nil}) == @skin
  end

  test "WeAllMatch.Champion.Skin.Chroma.build()" do
    assert WeAllMatch.Champion.Skin.Chroma.build(%{"id" => 266004, "colors" => ["#27211C", "#27211C"]}) == @chroma
  end

  test "WeAllMatch.Champion.Skin.uri()" do
    assert WeAllMatch.Champion.Skin.uri(@skin.index, @champion.id) == "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Aatrox_0.jpg"
  end
end
