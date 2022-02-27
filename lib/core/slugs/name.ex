defmodule Core.Slugs.Name do
  @moduledoc false
  use EctoAutoslugField.Slug, from: :name, to: :slug
end
