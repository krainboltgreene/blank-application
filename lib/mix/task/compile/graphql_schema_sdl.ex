defmodule Mix.Tasks.Compile.GraphqlSchemaSdl do
  @moduledoc false
  use Mix.Task.Compiler

  def run(_args) do
    Mix.Task.run("absinthe.schema.sdl", ["--schema=Graphql.Schema"])
    |> case do
      true -> :ok
      :noop -> :ok
      exception -> {:error, exception}
    end
  end
end
