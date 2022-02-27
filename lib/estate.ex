defmodule Estate do
  @moduledoc """
  This creates a simple state machine definition for a module
  """
  @spec state_machines(%{atom => %{atom => list(tuple)}}) :: [any]

  def state_machine({column_name, events}) when is_list(events) and is_atom(column_name) do
    Enum.flat_map(events, &transitions(&1, column_name))
  end

  def transitions({event_name, transitions}, column_name) when is_atom(event_name) and is_list(transitions) do
    Enum.map(transitions, &transition(&1, event_name, column_name))
  end

  def transition({from, to}, event_name, column_name) do
    quote do
      @desc "Called before #{unquote(event_name)}, with the changeset"
      def unquote(:"before_#{event_name}_from_#{from}")(
            %Ecto.Changeset{
              data: %{unquote(column_name) => unquote(Atom.to_string(from))}
            } = changeset
          ) do
        changeset
      end

      @desc "Called after #{unquote(event_name)}, with the changeset"
      def unquote(:"after_#{event_name}_from_#{from}")(
            %Ecto.Changeset{
              changes: %{unquote(column_name) => unquote(to)},
              data: %{unquote(column_name) => unquote(Atom.to_string(from))}
            } = changeset
          ) do
        changeset
      end

      @desc "Called after #{unquote(event_name)}!, with the saved record"
      def unquote(:"after_#{event_name}_from_#{from}")({
            :ok,
            %{
              unquote(column_name) => unquote(to)
            } = record
          }) do
        {:ok, record}
      end

      @desc "An action to change the state, if the transition matches, but doesn't save"
      def unquote(event_name)(
            %{unquote(column_name) => unquote(Atom.to_string(from))} = record
          ) do
        record
        |> Ecto.Changeset.change()
        |> unquote(:"before_#{event_name}_from_#{from}")()
        |> Ecto.Changeset.cast(%{unquote(column_name) => unquote(to)}, [
          unquote(column_name)
        ])
        |> Ecto.Changeset.validate_required(unquote(column_name))
        |> unquote(:"after_#{event_name}_from_#{from}")()
      end

      @desc "An action to change the state, if the transition matches, but does save"
      def unquote(:"#{event_name}!")(
            %{:id => id, unquote(column_name) => unquote(Atom.to_string(from))} = record
          )
          when not is_nil(id) do
        Core.Repo.transaction(fn ->
          record
          |> Ecto.Changeset.change()
          |> unquote(:"before_#{event_name}_from_#{from}")()
          |> Ecto.Changeset.cast(%{unquote(column_name) => unquote(to)}, [
            unquote(column_name)
          ])
          |> Ecto.Changeset.validate_required(unquote(column_name))
          |> Core.Repo.update()
          |> unquote(:"after_#{event_name}_from_#{from}")()
        end)
      end

      # If you can't match, then raise transition failure
    end
  end
  defmacro state_machines(machines) do
    Enum.flat_map(machines, &Estate.state_machine/1)
  end
end
