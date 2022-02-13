defmodule Cache do
  @moduledoc """
  A way to cache values to redis and pull them back out
  """
  require Logger

  @spec fetch(String.t(), (() -> value), integer | nil) ::
          {:commit, value}
          | {:error,
             atom
             | %{
                 :__exception__ => any,
                 :__struct__ => Redix.ConnectionError | Redix.Error,
                 optional(:message) => String.t(),
                 optional(:reason) => atom
               }}
          | {:ok,
             nil
             | String.t()
             | [nil | String.t() | [any] | integer | Redix.Error.t()]
             | integer
             | Redix.Error.t()}
        when value: any
  def fetch(key, hypothetical, expiration \\ nil)
      when is_bitstring(key) and is_function(hypothetical, 0) do
    Logger.debug("[Cache] Fetching from cache", key: key, expiration: expiration)

    read(key)
    |> case do
      {:ok, nil} -> write(key, hypothetical.(), expiration)
      result -> result
    end
  end

  @spec read(String.t()) ::
          {:error,
           atom
           | %{
               :__exception__ => any,
               :__struct__ => Redix.ConnectionError | Redix.Error,
               optional(:message) => String.t(),
               optional(:reason) => atom
             }}
          | {:ok,
             nil
             | String.t()
             | [nil | String.t() | [any] | integer | Redix.Error.t()]
             | integer
             | Redix.Error.t()}
  def read(key) when is_bitstring(key) do
    Logger.debug("[Cache] Reading from cache", key: key)
    Redix.command(:redix, ["GET", key])
  end

  @spec write(String.t(), any, nil | integer) ::
          {:commit, any}
          | {:error,
             atom | Redix.ConnectionError.t | Redix.Error.t}
          | {:ok,
             nil
             | String.t()
             | [nil | String.t() | [any] | integer | Redix.Error.t()]
             | integer
             | Redix.Error.t()}
  def write(key, value, nil) when is_bitstring(key) do
    Logger.debug("Writing to cache", key: key)

    Redix.command(:redix, ["SET", key, value])
    |> case do
      {:ok, "OK"} -> {:commit, value}
      result -> result
    end
  end

  def write(key, value, expiration) when is_bitstring(key) and is_integer(expiration) do
    Logger.debug("[Cache] Writing to cache", key: key, expiration: expiration)

    Redix.command(:redix, ["SET", key, value, "PX", expiration])
    |> case do
      {:ok, "OK"} -> {:commit, value}
      result -> result
    end
  end

  @spec erase(String.t()) ::
          {:error,
           atom
           | Redix.ConnectionError.t | Redix.Error.t}
          | {:ok,
             nil
             | String.t()
             | [nil | String.t() | [any] | integer | Redix.Error.t()]
             | integer
             | Redix.Error.t()}
  def erase(key) when is_bitstring(key) do
    Logger.debug("[Cache] Erasing from cache", key: key)
    Redix.command(:redix, ["DEL", key])
  end
end
