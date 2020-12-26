defmodule Database.Models.ElixirModuleAttribute do
  use Ecto.Schema
  import AbstractSyntaxTreeBehavior

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  embedded_schema do
    field :name, :string, default: ""
    field :value, :string, default: ""
  end

  def as_ast(%{name: name, value: value})
      when is_bitstring(name) and
             is_bitstring(value) do
    {
      :@,
      [],
      [
        {
          String.to_atom(name),
          [],
          [
            value |> to_quote
          ]
        }
      ]
    }
  end
end
