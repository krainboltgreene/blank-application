defmodule EstateTest do
  use ExUnit.Case
  doctest Estate

  test "greets the world" do
    assert Estate.hello() == :world
  end
end
