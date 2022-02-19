defmodule Utilities do
  @moduledoc """
  A set of very valuable utilities
  """
  require Logger

  @spec couple_with(list(value) | value, pairing) :: list({value, pairing}) | {value, pairing}
        when pairing: map, value: map
  def couple_with(listing, pairing) when is_list(listing) and is_map(pairing) do
    listing
    |> Enum.map(fn value -> {value, pairing} end)
  end

  def couple_with(value, pairing) when is_map(pairing) do
    {value, pairing}
  end

  @spec right({any, value}) :: value when value: any
  def right({_, value}) do
    value
  end

  @spec left({value, any}) :: value when value: any
  def left({value, _}) do
    value
  end

  @spec find_header(list({key, value}), key, default) :: value | default
        when key: String.t(), value: String.t(), default: any
  def find_header(headers, key, default \\ nil) when is_list(headers) and is_binary(key) do
    headers
    |> Enum.find(default, fn {header, _value} -> header == key end)
    |> right()
  end
end
