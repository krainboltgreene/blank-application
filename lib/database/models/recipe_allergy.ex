defmodule Database.Models.RecipeAllergy do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipe_allergies" do
    belongs_to :allergy, Database.Models.Allergy, primary_key: true
    belongs_to :recipe, Database.Models.Recipe, primary_key: true
  end
end
