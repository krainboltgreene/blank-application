# An example comment
defmodule Example do
  @moduledoc """
  Conveniences for translating and building error messages.
  """
  @type word() :: String.t()
  @type dict(key, value) :: [{key, value}]
  @typep type_name :: type
  @opaque type_name :: type
  @callback my_fun(arg :: any) :: any
  @macrocallback my_macro(arg :: any) :: Macro.t()
  @optional_callbacks non_vital_fun: 0, non_vital_macro: 1

  @doc """
  Translates an error message using gettext.
  """
  @spec example(%{a: binary, b: binary | integer()}) :: binary
        when (is_bitstring(b) or is_integer(b)) and is_bitstring(a)
  def example(%{a: a, b: b}) when is_bitstring(a) and is_bitstring(b) do
    "#{a}#{b}"
  end

  @doc false
  # An example comment 2
  @spec example2(a, b) :: {a, b} when a: atom, b: integer
  def example2(%{a: a, b: b}) do
    "#{a}#{b}"
  end
end
