defmodule Core.MatcherTest do
  use ExUnit.Case
  doctest Core.Matcher

  @input [
    {
      :john,
      ["Aatrox", "Swain", "KogMaw"]
    },
    {
      :stacy,
      ["Pantheon", "Seraphine", "Yuumi"]
    }
  ]

  test "Core.Matcher.run()" do
    assert Core.Matcher.run(value) == [
      [
        {
          :john,
          "Dragontamer Swain"
        },
        {
          :stacy,
          "Dragonslayer Pantheon"
        }
      ],
      [
        {
          :john,
          "Beemaw"
        },
        {
          :stacy,
          "Yuubee"
        }
      ]
    ]
  end
end
