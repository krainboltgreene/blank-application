defmodule Database.Models do

  @spec has_standard_behavior :: {:__block__, [], [{:def, [...], [...]}, ...]}
  defmacro has_standard_behavior() do
    quote do
      def find_or_initialize_by_external_id(attributes) do
        Database.Repository.get_by(__MODULE__, external_id: attributes.external_id)
        |> case do
          nil -> changeset(%__MODULE__{}, attributes)
          record -> record
        end
      end
      def create_or_update_by_external_id(attributes) do
        Database.Repository.get_by(__MODULE__, external_id: attributes.external_id)
        |> case do
          nil -> create(attributes)
          record -> record |> update(attributes)
        end
      end

      def create(attributes) do
        changeset(%__MODULE__{}, attributes)
        |> case do
          %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
          %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
        end
      end

      def update(record, attributes) do
        changeset(record, attributes)
        |> case do
          %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.update(changeset)
          %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
        end
      end
    end
  end
end
