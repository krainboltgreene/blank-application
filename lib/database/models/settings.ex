defmodule Database.Models.Settings do
  @moduledoc false
  use Ecto.Schema


  @type t :: %__MODULE__{
    light_mode: boolean
  }
  embedded_schema do
    field(:light_mode, :boolean, default: true)
  end

  @spec changeset(Database.Models.Settings.t(), map) ::
          Ecto.Changeset.t(Database.Models.Settings.t())
  def changeset(record, attributes) do
    record
    |> Ecto.Changeset.cast(attributes, [:light_mode])
  end
end
