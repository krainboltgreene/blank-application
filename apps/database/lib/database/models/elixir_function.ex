defmodule Database.Models.ElixirFunction do
  use Ecto.Schema
  import Ecto.Changeset
  import Database.Models.Mixins.Ast

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "elixir_functions" do
    field :declaration, :string, default: "def"
    field :documentation, :string, default: ""
    field :guards, :string, default: ""
    field :inputs, :string, default: ""
    field :name, :string, default: ""
    field :body, :string, default: ""
    field :ast, :string
    field :source, :string
    field :slug, :string
    field :deployment_state, :string, default: "dead"
    field :hash, :string
    embeds_many :elixir_specs, Database.Models.ElixirFunctionSpec
    belongs_to :elixir_module, Database.Models.ElixirModule, primary_key: true

    timestamps()
  end

  @spec as_ast(%{
    body: String.t(),
    declaration: String.t(),
    documentation: String.t(),
    elixir_module: %Database.Models.ElixirModule{slug: String.t()},
    elixir_specs: [%Database.Models.ElixirFunctionSpec{inputs: String.t(), return: String.t()}],
    guards: String.t(),
    inputs: String.t(),
    name: String.t(),
    slug: String.t(),
    hash: String.t()
  }) :: {:defmodule, [], [[{any, any}, ...] | {:__aliases__, [], [...]}, ...]}
  def as_ast(
    %{
      declaration: declaration,
      documentation: documentation,
      elixir_specs: elixir_specs,
      guards: guards,
      inputs: inputs,
      name: name,
      body: body,
      elixir_module: %{
        slug: elixir_module_slug,
        documentation: elixir_module_documentation,
      },
      slug: slug,
      hash: hash,
    })
  when
    is_bitstring(declaration)
    and
    is_bitstring(documentation)
    and
    is_list(elixir_specs)
    and
    is_bitstring(guards)
    and
    is_bitstring(inputs)
    and
    is_bitstring(name)
    and
    is_bitstring(body)
    and
    is_bitstring(elixir_module_slug)
    and
    is_bitstring(elixir_module_documentation)
    and
    is_bitstring(slug)
    and
    is_bitstring(hash)
  do
    {
      :defmodule,
      [],
      [
        {:__aliases__, [], [String.to_atom(elixir_module_slug)]},
        [
          do: {
            :__block__,
            [],
            Enum.concat([
              [{:@, [], [{:doc, [], [documentation]}]}],
              Enum.map(elixir_specs, &Database.Models.ElixirFunctionSpec.as_ast/1),
              [{declaration, [], [{:when, [], [guards |> to_quote]}, [do: body |> to_quote]]}]
            ])
          }
        ]
      ]}
  end

  @spec as_source(%{optional(any) => any, data: %{optional(any) => any, ast: binary}}) :: %{optional(any) => any, ast: binary, source: binary}
  defp as_source(%{data: %{ast: ast}} = record) when is_bitstring(ast) do
    Map.merge(record, %{data: %{source: Macro.to_string(ast)}})
  end

  @doc false
  @spec changeset(map, map) :: Ecto.Changeset.t()
  def changeset(elixir_functions, attrs) do
    elixir_functions
    |> cast(attrs, [])
    |> as_source
    |> validate_required([])
    |> unique_constraint(:slug)
  end
end
