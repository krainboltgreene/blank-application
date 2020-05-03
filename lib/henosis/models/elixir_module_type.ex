defmodule Henosis.Models.ElixirModuleType do
  use Ecto.Schema
  import Henosis.Models.Mixins.Ast

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  embedded_schema do
    field :name, :string, default: ""
    field :left, :string, default: ""
    field :right, :string, default: ""
  end

  def as_ast(%{name: name, left: left, right: right})
  when
    is_bitstring(name)
    and
    is_bitstring(left)
    and
    is_bitstring(right)
  do
    {:@, [], [ {:type, [], [{:"::", [], [left |> to_quote, [right |> to_quote]]}]}]}
  end
end
