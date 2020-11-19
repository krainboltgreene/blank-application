defmodule UtilitiesTest do
  @moduledoc false
  use ExUnit.Case
  doctest Utilities

  test "as_table_name() for hashtag" do
    assert Utilities.as_table_name("#System") == "system"
  end

  test "as_table_name() for space" do
    assert Utilities.as_table_name("Sovereignty Structures") == "sovereignty_structure"
  end
end
