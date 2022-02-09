defmodule Database.Models do
  @spec has_standard_behavior :: {:__block__, [], [{:def, [...], [...]}, ...]}
  defmacro has_standard_behavior() do
    quote do
      def create(attributes) do
        changeset(%__MODULE__{}, attributes)
        |> case do
          %Ecto.Changeset{valid?: true} = changeset -> Database.Repo.insert(changeset)
          %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
        end
      end

      def update(record, attributes) do
        changeset(record, attributes)
        |> case do
          %Ecto.Changeset{valid?: true} = changeset -> Database.Repo.update(changeset)
          %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
        end
      end
    end
  end
end
