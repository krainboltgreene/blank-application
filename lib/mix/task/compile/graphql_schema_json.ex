defmodule Mix.Tasks.Compile.GraphqlSchemaJson do
  @moduledoc false
  use Mix.Task.Compiler

  def run(_args) do
    Mix.Task.run("absinthe.schema.json", ["--schema=Graphql.Schema"])
    |> case do
      true -> :ok
      exception -> {:error, exception}
    end
  end
end
