defmodule Database.Models.MenuItemTag do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_items_tags" do
    belongs_to :menu_item, Database.Models.MenuItem, primary_key: true
    belongs_to :tag, Database.Models.Tag, primary_key: true
  end
end
