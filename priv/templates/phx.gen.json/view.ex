defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>View do
  use <%= inspect context.web_module %>, :view

  def render("index.json", %{<%= schema.plural %>: <%= schema.plural %>}) do
    %{data: render_many(<%= schema.plural %>, <%= inspect schema.module %>View, "<%= schema.singular %>.json")}
  end

  def render("show.json", %{<%= schema.singular %>: <%= schema.singular %>}) do
    %{data: render_one(<%= schema.singular %>, <%= inspect schema.module %>View, "<%= schema.singular %>.json")}
  end

  def render("<%= schema.singular %>.json", %{<%= schema.singular %>: <%= schema.singular %>}) do
    %{
<%= [{:id, :id} | schema.attrs] |> Enum.map(fn {k, _} -> "      #{k}: #{schema.singular}.#{k}" end) |> Enum.join(",\n")  %>
    }
  end
end
