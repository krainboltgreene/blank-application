defmodule <%= inspect schema.module %> do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
<%= Mix.Phoenix.Schema.format_fields_for_schema(schema) %>
  end

  @doc false
  def changeset(%<%= inspect schema.module %>{} = <%= schema.singular %>, attrs) do
    <%= schema.singular %>
    |> cast(attrs, [<%= Enum.map_join(schema.attrs, ", ", &inspect(elem(&1, 0))) %>])
    |> validate_required([<%= Enum.map_join(schema.attrs, ", ", &inspect(elem(&1, 0))) %>])
  end
end
