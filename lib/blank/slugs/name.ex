defmodule Blank.Slugs.Name do
  use EctoAutoslugField.Slug, from: :name, to: :slug
end
