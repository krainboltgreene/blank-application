defmodule Database.Models.RecipeDiet do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipe_diets" do
    belongs_to :recipe, Database.Models.Recipe, primary_key: true
    belongs_to :diet, Database.Models.Diet, primary_key: true
  end
end
