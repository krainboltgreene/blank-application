defmodule Henosis.Models.ElixirFunctionSpec do
  use Ecto.Schema
  import Ecto.Changeset
  import Henosis.Models.Mixins.Ast

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  embedded_schema do
    field :inputs, :string, default: ""
    field :return, :string, default: ""
    field :guards, :string, default: ""
  end

  @spec as_ast(%{elixir_function: %{slug: bitstring}, guards: bitstring, inputs: bitstring, return: bitstring}) ::
          {:@, [], [{:spec, [], [...]}, ...]}
  def as_ast(%{elixir_function: %{slug: elixir_function_slug}, inputs: inputs, return: return, guards: guards})
  when
    is_bitstring(elixir_function_slug)
    and
    is_bitstring(inputs)
    and
    is_bitstring(return)
    and
    is_bitstring(guards)
  do
    {
      :@,
      [],
      [
        {
          :spec,
          [],
          [
            {:"::", [], [{String.to_atom(elixir_function_slug), [], [inputs |> to_quote]}, return |> to_quote]}
          ]
        }
      ]
    }
  end

  @doc false
  @spec changeset(map, map) :: Ecto.Changeset.t()
  def changeset(elixir_functions, attrs) do
    elixir_functions
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint(:slug)
  end
end
