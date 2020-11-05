defmodule Graphql.Resolvers do
  @moduledoc false
  require Logger

  @spec creatable(any, :authenticated) ::
          {:__block__, [], [{:@, [...], [...]} | {:def, [...], [...]}, ...]}
  defmacro creatable(model, :authenticated) do
    quote do
      @spec create(any, any, %{context: %{:current_account => nil}}) :: {:error, :unauthenticated}
      def create(_parent, _arguments, %{context: %{current_account: nil}}) do
        {:error, :unauthenticated}
      end
      @spec create(any, %{input: map}, %{
              context: %{:current_account => %Database.Models.Account{id: String.t()}}
            }) ::
              {:ok, unquote(model).t} | {:error, Ecto.Changeset.t}
      def create(_parent, %{input: input}, _resolution) do
        %unquote(model){}
        |> unquote(model).changeset(input)
        |> case do
          %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
          %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
        end
      end
    end
  end

  @spec updatable(any, :authenticated) ::
          {:__block__, [], [{:@, [...], [...]} | {:def, [...], [...]}, ...]}
  defmacro updatable(model, :authenticated) do
    quote do
      @spec update(any, any, %{context: %{:current_account => nil}}) :: {:error, :unauthenticated}
      def update(_parent, _arguments, %{context: %{current_account: nil}}) do
        {:error, :unauthenticated}
      end
      @spec update(
              any,
              %{input: %{:id => String.t()}},
              %{context: %{:current_account => %Database.Models.Account{id: String.t()}}}
            ) ::
            {:ok, unquote(model).t} | {:error, Ecto.Changeset.t | atom}
      def update(_parent, %{input: %{id: id} = input}, %{
            context: %{current_account: current_account}
          })
          when is_bitstring(id) do
        unquote(model)
        |> Database.Repository.get(id)
        |> case do
          nil -> {:error, :not_found}
          account -> unquote(model).changeset(account, input)
        end
        |> case do
          %Ecto.Changeset{valid?: true} = changeset -> Database.Repository.insert(changeset)
          %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
          {:error, _} = rejection -> rejection
        end
      end
    end
  end

  defmacro destroyable(model, :authenticated) do
    quote do
      @spec destroy(any, any, %{context: %{:current_account => nil}}) ::
              {:error, :unauthenticated}
      def destroy(_parent, _arguments, %{context: %{current_account: nil}}) do
        {:error, :unauthenticated}
      end
      @spec destroy(any, %{input: %{id: String.t()}}, %{
              context: %{:current_account => %Database.Models.Account{id: String.t()}}
            }) ::
              {:ok, :no_content} | {:error, Ecto.Changeset.t | atom}
      def destroy(_parent, %{input: %{id: id}}, %{context: %{current_account: current_account}})
          when is_bitstring(id) do
        unquote(model)
        |> Database.Repository.get(id)
        |> case do
          nil -> {:error, :not_found}
          account -> Database.Repository.delete(account)
        end
        |> case do
          {:ok, _} -> {:ok, :no_content}
          rejection -> rejection
        end
      end
    end
  end

  defmacro listable(model, :authenticated) do
    quote do
      require Ecto.Query
      @default_limit 10

      @spec list(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
      def list(_parent, _arguments, %{context: %{current_account: nil}}) do
        {:error, :unauthenticated}
      end
      @spec list(any, %{optional(:input) => %{limit: integer}}, %{
              context: %{current_account: %Database.Models.Account{id: String.t()}}
            }) :: {:ok, list(unquote(model).t())}
      def list(_parent, %{input: %{limit: limit}}, %{context: %{current_account: current_account}})
          when is_integer(limit) and limit > 0 and limit < 100 do
        {:ok, unquote(model) |> Ecto.Query.limit(^limit) |> Database.Repository.all()}
      end
      def list(_parent, _arguments, %{context: %{current_account: current_account}}) do
        {:ok, unquote(model) |> Ecto.Query.limit(@default_limit) |> Database.Repository.all()}
      end
    end
  end

  @spec findable(any, :authenticated) ::
          {:__block__, [], [{:@, [...], [...]} | {:def, [...], [...]}, ...]}
  defmacro findable(model, :authenticated) do
    quote do
      @spec find(any, any, %{context: %{current_account: nil}}) :: {:error, :unauthenticated}
      def find(_parent, _arguments, %{context: %{current_account: nil}}) do
        {:error, :unauthenticated}
      end
      @spec find(any, %{input: %{id: String.t()}}, %{
              context: %{current_account: %Database.Models.Account{id: String.t()}}
            }) :: {:ok, %unquote(model){} | nil}
      def find(_parent, %{input: %{id: id}}, _resolution)
          when not is_nil(id) and is_bitstring(id) do
        {:ok, unquote(model) |> Database.Repository.get(id)}
      end
    end
  end
end
