defmodule Database.Models.ElixirModule do
  use Ecto.Schema
  import Ecto.Changeset
  import Estate, only: [state_machines: 1]
  import AbstractSyntaxTreeBehavior

  state_machines(
    deployment_state: [
      push: [dead: :live],
      pull: [live: :dead]
    ]
  )

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "elixir_modules" do
    field :name, :string, default: ""
    field :documentation, :string, default: ""
    field :body, :string, default: ""
    field :ast, :string
    field :source, :string
    field :slug, :string
    field :deployment_state, :string, default: "dead"
    field :hash, :string
    embeds_many :elixir_types, Database.Models.ElixirModuleType
    embeds_many :elixir_typeps, Database.Models.ElixirModuleType
    embeds_many :elixir_opeques, Database.Models.ElixirModuleType
    embeds_many :elixir_callbacks, Database.Models.ElixirModuleType
    embeds_many :elixir_macrocallbacks, Database.Models.ElixirModuleType

    many_to_many :elixir_behaviours, Database.Models.ElixirModule,
      join_through: "elixir_behaviors"

    many_to_many :elixir_directives, Database.Models.ElixirModule,
      join_through: "elixir_directives"

    embeds_many :elixir_optional_callbacks, Database.Models.ElixirModuleAttribute
    embeds_many :elixir_module_attributes, Database.Models.ElixirModuleAttribute
    has_many :elixir_functions, Database.Models.ElixirFunction
    belongs_to :previous_elixir_module, Database.Models.ElixirModule

    timestamps()
  end

  defp as_hash(%{source: source}) when is_bitstring(source) do
    :crypto.hash(:md5, source) |> Base.encode16(case: :lower)
  end

  defp as_slug(%{name: name, hash: hash})
       when is_bitstring(name) and is_bitstring(hash) do
  end

  def as_ast(%{
        slug: slug,
        hash: hash,
        body: body,
        documentation: documentation,
        elixir_types: elixir_types,
        elixir_typeps: elixir_typeps,
        elixir_opeques: elixir_opeques,
        elixir_callbacks: elixir_callbacks,
        elixir_macrocallbacks: elixir_macrocallbacks,
        elixir_optional_callbacks: elixir_optional_callbacks,
        elixir_behaviours: elixir_behaviours,
        elixir_directives: elixir_directives,
        elixir_module_attributes: elixir_module_attributes
      })
      when is_bitstring(slug) and
             is_bitstring(hash) and
             is_bitstring(body) and
             is_bitstring(documentation) and
             is_list(elixir_types) and
             is_list(elixir_typeps) and
             is_list(elixir_opeques) and
             is_list(elixir_callbacks) and
             is_list(elixir_macrocallbacks) and
             is_list(elixir_optional_callbacks) and
             is_list(elixir_module_attributes) and
             is_list(elixir_behaviours) and
             is_list(elixir_directives) do
    # {:defmodule, [],
    #   [
    #     {:__aliases__, [], [String.to_atom(slug)]},
    #     [
    #       do: {:__block__, [],
    #       [
    #         Enum.concat([
    #           [{:@, [], [{:moduledoc, [], [documentation]}]}],
    #           Enum.map(elixir_types, &Database.Models.ElixirModuleType.as_ast/1),
    #           Enum.map(elixir_typeps, &Database.Models.ElixirModuleType.as_ast/1),
    #           Enum.map(elixir_opeques, &Database.Models.ElixirModuleType.as_ast/1),
    #           Enum.map(elixir_callbacks, &Database.Models.ElixirModuleType.as_ast/1),
    #           Enum.map(elixir_macrocallbacks, &Database.Models.ElixirModuleType.as_ast/1),
    #           Enum.map(elixir_optional_callbacks, &Database.Models.ElixirModuleAttribute.as_ast/1),
    #         ]),
    #         {:@, [],
    #           [{:doc, [], ["Translates an error message using gettext.\n"]}]},
    #         {:@, [],
    #           [
    #             {:spec, [],
    #             [
    #               {:when, [],
    #                 [
    #                   {:"::", [],
    #                   [
    #                     {:example, [],
    #                       [
    #                         {:%{}, [],
    #                         [
    #                           # a: {:binary, [], nil},
    #                           # b: {:|, [], [{...}, ...]}
    #                         ]}
    #                       ]},
    #                     {:binary, [], nil}
    #                   ]},
    #                   {:and, [],
    #                   [
    #                     {:or, [],
    #                       [
    #                         {:is_bitstring, [], [{:b, [], nil}]},
    #                         {:is_integer, [], [{:b, [], nil}]}
    #                       ]},
    #                     {:is_bitstring, [], [{:a, [], nil}]}
    #                   ]}
    #                 ]}
    #             ]}
    #           ]},
    #         {:def, [],
    #           [
    #             {:when, [],
    #             [
    #               {:example, [],
    #                 [
    #                   {:%{}, [],
    #                   [a: {:a, [], nil}, b: {:b, [], nil}]}
    #                 ]},
    #               {:and, [],
    #                 [
    #                   {:is_bitstring, [], [{:a, [], nil}]},
    #                   {:is_bitstring, [], [{:b, [], nil}]}
    #                 ]}
    #             ]},
    #             [
    #               do: {:<<>>, [],
    #               [
    #                 {:"::", [],
    #                   [
    #                     {{:., [], [Kernel, :to_string]}, [],
    #                     [{:a, [], nil}]},
    #                     {:binary, [], nil}
    #                   ]},
    #                 {:"::", [],
    #                   [
    #                     {{:., [], [Kernel, :to_string]}, [],
    #                     [{:b, [], nil}]},
    #                     {:binary, [], nil}
    #                   ]}
    #               ]}
    #             ]
    #           ]},
    #         {:@, [], [{:doc, [], [false]}]},
    #         {:@, [],
    #           [
    #             {:spec, [],
    #             [
    #               {:when, [],
    #                 [
    #                   {:"::", [],
    #                   [
    #                     {:example2, [],
    #                       [{:a, [], nil}, {:b, [], nil}]},
    #                     {{:a, [], nil}, {:b, [], nil}}
    #                   ]},
    #                   [a: {:atom, [], nil}, b: {:integer, [], nil}]
    #                 ]}
    #             ]}
    #           ]},
    #         {:def, [],
    #           [
    #             {:example2, [],
    #             [
    #               {:%{}, [],
    #                 [a: {:a, [], nil}, b: {:b, [], nil}]}
    #             ]},
    #             [
    #               do: {:<<>>, [],
    #               [
    #                 {:"::", [],
    #                   [
    #                     {{:., [], [Kernel, :to_string]}, [],
    #                     [{:a, [], nil}]},
    #                     {:binary, [], nil}
    #                   ]},
    #                 {:"::", [],
    #                   [
    #                     {{:., [], [Kernel, :to_string]}, [],
    #                     [{:b, [], nil}]},
    #                     {:binary, [], nil}
    #                   ]}
    #               ]}
    #             ]
    #           ]}
    #       ]}
    #     ]
    #   ]}
    #   {
    #     :defmodule,
    #     [],
    #     [
    #       {:__aliases__, [], [String.to_atom(slug)]},
    #       [
    #         do: {
    #           :__block__,
    #           [],
    #           Enum.concat([
    #             [{:@, [], [{:moduledoc, [], [documentation]}]}],
    #             # ,
    #             Enum.map(elixir_typeps, &Database.Models.ElixirModuleType.as_ast/1),
    #             Enum.map(elixir_opeques, &Database.Models.ElixirModuleType.as_ast/1),
    #             Enum.map(elixir_callbacks, &Database.Models.ElixirModuleType.as_ast/1),
    #             Enum.map(elixir_macrocallbacks, &Database.Models.ElixirModuleType.as_ast/1),
    #             Enum.map(elixir_optional_callbacks, &Database.Models.ElixirModuleType.as_ast/1),
    #             Enum.map(elixir_module_attributes, &Database.Models.ElixirModuleType.as_ast/1),
    #             Enum.map(elixir_behaviours, &Map.get(&1, "slug")),
    #             Enum.map(elixir_directives, &Map.get(&1, "slug")),
    #           ])
    #         }
    #       ]
    #     ]}
  end

  @spec changeset(map, map) :: Ecto.Changeset.t()
  @doc false
  def changeset(elixir_module, attrs) do
    elixir_module
    |> cast(attrs, ["source", "ast", "hash"])
    |> validate_required(["source", "ast", "hash"])
    |> unique_constraint(:slug)
  end
end
