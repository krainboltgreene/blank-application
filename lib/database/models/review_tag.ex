defmodule Database.Models.ReviewTag do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews_tags" do
    belongs_to :review, Database.Models.Review, primary_key: true
    belongs_to :tag, Database.Models.Tag, primary_key: true
  end
end
