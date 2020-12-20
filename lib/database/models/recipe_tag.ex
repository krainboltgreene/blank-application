defmodule Database.Models.RecipeTag do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipes_tags" do
    belongs_to :recipe, Database.Models.Recipe, primary_key: true
    belongs_to :tag, Database.Models.Tag, primary_key: true
  end
end
