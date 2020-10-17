defmodule Graphql.Resolvers do
  require Logger

  @spec creatable(any, :authenticated) ::
          {:__block__, [], [{:@, [...], [...]} | {:def, [...], [...]}, ...]}
  defmacro creatable(model, :authenticated) do
    quote do
      @spec create(any, %{input: map}, %{
              context: %{:current_account => %Database.Models.Account{id: String.t()}}
            }) ::
              {:ok, %unquote(model){}} | {:error, %Ecto.ChangeError{} | :internal_server_error}
      def create(_parent, %{input: input}, %{context: %{current_account: current_account}})
          when not is_nil(current_account) do
        %unquote(model){}
        |> unquote(model).changeset(input)
        |> case do
          %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
          %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
        end
      end

      @spec create(any, any, %{context: %{:current_account => nil}}) :: {:error, :unauthenticated}
      def create(_parent, _arguments, %{context: %{current_account: current_account}})
          when is_nil(current_account) do
        {:error, :unauthenticated}
      end
    end
  end

  @spec updatable(any, :authenticated) ::
          {:__block__, [], [{:@, [...], [...]} | {:def, [...], [...]}, ...]}
  defmacro updatable(model, :authenticated) do
    quote do
      @spec update(
              any,
              %{input: %{:id => String.t()}},
              %{context: %{:current_account => %Database.Models.Account{id: String.t()}}}
            ) ::
              {:ok, %unquote(model){}} | {:error, %Ecto.ChangeError{} | :internal_server_error}
      def update(_parent, %{input: %{id: id} = input}, %{
            context: %{current_account: current_account}
          })
          when is_bitstring(id) do
        Database.Repository.get!(unquote(model), id)
        |> unquote(model).changeset(input)
        |> case do
          %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
          %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
        end
      end

      @spec update(any, any, %{context: %{:current_account => nil}}) :: {:error, :unauthenticated}
      def update(_parent, _arguments, %{context: %{current_account: current_account}})
          when is_nil(current_account) do
        {:error, :unauthenticated}
      end
    end
  end

  defmacro destroyable(model, :authenticated) do
    quote do
      @spec destroy(any, %{input: %{id: String.t()}}, %{
              context: %{:current_account => %Database.Models.Account{id: String.t()}}
            }) ::
              {:ok, :no_content} | {:error, %Ecto.ChangeError{} | :internal_server_error}
      def destroy(_parent, %{input: %{id: id}}, %{context: %{current_account: current_account}})
          when is_bitstring(id) do
        Database.Repository.get!(unquote(model), id)
        |> Database.Repository.delete()
      end

      @spec destroy(any, any, %{context: %{:current_account => nil}}) ::
              {:error, :unauthenticated}
      def destroy(_parent, _arguments, %{context: %{current_account: current_account}})
          when is_nil(current_account) do
        {:error, :unauthenticated}
      end
    end
  end

  defmacro listable(model, :authenticated) do
    quote do
      require Ecto.Query
      @default_limit 10
      @spec list(any, %{optional(:input) => %{limit: integer}}, %{
              context: %{current_account: %Database.Models.Account{id: String.t()}}
            }) :: {:ok, list(%unquote(model){})}
      def list(_parent, %{input: %{limit: limit}}, %{context: %{current_account: current_account}})
          when is_integer(limit) and limit > 0 and not is_nil(current_account) do
        {:ok, unquote(model) |> Ecto.Query.limit(^limit) |> Database.Repository.all()}
      end

      def list(_parent, _arguments, %{context: %{current_account: current_account}})
          when not is_nil(current_account) do
        {:ok, unquote(model) |> Ecto.Query.limit(@default_limit) |> Database.Repository.all()}
      end

      @spec list(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
      def list(_parent, _arguments, %{context: %{current_account: current_account}})
          when is_nil(current_account) do
        {:error, :unauthenticated}
      end
    end
  end

  defmacro findable(model, :authenticated) do
    quote do
      @spec find(any, %{input: %{id: String.t()}}, %{
              context: %{current_account: %Database.Models.Account{id: String.t()}}
            }) :: {:ok, %unquote(model){} | nil}
      def find(_parent, %{input: %{id: id}}, _resolution)
          when not is_nil(id) and is_bitstring(id) do
        {:ok, unquote(model) |> Database.Repository.get(id)}
      end

      @spec find(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
      def find(_parent, _arguments, %{context: %{current_account: current_account}})
          when is_nil(current_account) do
        {:error, :unauthenticated}
      end
    end
  end
end
