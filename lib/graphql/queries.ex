defmodule Graphql.Queries do
  @moduledoc false
  defmacro listable_field(name) do
    quote do
      @desc unquote("Get all #{name |> Inflex.pluralize()}")
      field unquote(name |> Inflex.pluralize() |> String.to_atom()), list_of(unquote(name)) do
        arg(:input, :list_parameters)

        resolve(&__MODULE__.list/3)
      end
    end
  end

  defmacro findable_field(name) do
    quote do
      @desc unquote("Get an #{name} by id")
      field unquote(name), unquote(name) do
        arg(:input, non_null(:identity))

        resolve(&__MODULE__.find/3)
      end
    end
  end
end
