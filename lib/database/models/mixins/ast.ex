defmodule Database.Models.Mixins.Ast do
  @spec to_quote(String.t()) :: any()
  def to_quote(value) when is_bitstring(value) do
    value |> Code.string_to_quoted |> elem(1)
  end
end
