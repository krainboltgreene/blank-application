defmodule Core.Users.Profile do
  @moduledoc false
  use Ecto.Schema

  @type t :: %__MODULE__{
          public_name: String.t() | nil
        }
  embedded_schema do
    field(:public_name, :string)
  end

  @spec changeset(Core.Users.Profile.t(), map) ::
          Ecto.Changeset.t(Core.Users.Profile.t())
  def changeset(record, attributes) do
    record
    |> Ecto.Changeset.cast(attributes, [:public_name])
  end
end
