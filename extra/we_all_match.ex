defmodule WeAllMatch do
  @moduledoc """
  Documentation for `WeAllMatch`.
  """
  def pull do
    [
      WeAllMatch.Universe.all(),
      WeAllMatch.Skinline.all(),
      WeAllMatch.Champion.all(),
    ]
  end
end
