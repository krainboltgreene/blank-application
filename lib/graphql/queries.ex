defmodule Graphql.Queries do
  defmacro listable(name, resolver) do
    quote do
      @desc unquote("Get all #{name |> Inflex.pluralize}")
      field unquote(name |> Inflex.pluralize |> String.to_atom), list_of(unquote(name)) do
        arg(:input, :list_parameters)

        resolve(&unquote(resolver).list/3)
      end
    end
  end

  defmacro findable(name, resolver) do
    quote do
      @desc unquote("Get an #{name} by id")
      field unquote(name), unquote(name) do
        arg(:input, non_null(:identity))

        resolve(&unquote(resolver).find/3)
      end
    end
  end
end
