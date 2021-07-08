/* eslint-disable func-style */
import React from "react";
import {text} from "@storybook/addon-knobs";
import {number} from "@storybook/addon-knobs";
import {object} from "@storybook/addon-knobs";
import {array} from "@storybook/addon-knobs";
import {snake} from "case";
import ElixirFunction from ".";

export default {title: "<ElixirFunction>"};
export function normal () {
  const declaration = text("declaration", "def");
  const name = text("name", "Greet Person");
  const version = number("version", 1, {range: true, min: 1, max: 90, step: 1});
  const typespec = text("typespec", "{:__block__, [], [{:import, [...], [...]} | {:use, [...], [...]}, ...]}");
  const documentation = text("doc", "When used, dispatch to the appropriate controller/view/etc.\n\nAn example.");
  const elixirModule = object("elixirModule", {name: "Example", version: 1, slug: "Example.V1"});
  const inputs = array("inputs", ["name", "type"]);
  const guards = array("guards", ["is_bitstring(name)", "and", "is_positive(type)"]);
  const body = text("body", "fetch_name\nprint_name");
  const slug = `${snake(name)}_v${version}`;
  const source = `
defmodule ${elixirModule.slug}
  @doc """
  ${documentation.split("\n").join("\n  ")}
  """

  @spec ${slug} :: ${typespec}
  ${declaration} ${slug}(${inputs}) when ${guards.join(" ")} do
    ${body.split("\n").join("\n    ")}
  end
end`;

  return <ElixirFunction
    declaration={declaration}
    name={name}
    version={version}
    typespec={typespec}
    documentation={documentation}
    elixirModule={elixirModule}
    inputs={inputs}
    guards={guards}
    body={body}
    source={source}
    slug={slug}
  />;
}
