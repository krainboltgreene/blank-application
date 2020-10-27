defmodule Utilities do
  require Logger

  @spec couple_with(list(value) | value, pairing) :: list({value, pairing}) | {value, pairing}
        when pairing: map, value: map
  def couple_with(listing, pairing) when is_list(listing) and is_map(pairing) do
    listing
    |> Enum.map(fn value -> {value, pairing} end)
  end

  def couple_with(value, pairing) when is_map(pairing) do
    {value, pairing}
  end

  @spec as_table_name(String.t()) :: String.t()
  def as_table_name(string) when is_binary(string) do
    String.downcase(string)
    |> String.replace(~r/\s/, "_")
    |> String.replace(~r/#/, "")
    |> Inflex.singularize()
  end

  @spec tap(value, (value -> any())) :: value when value: any
  def tap(value, function) when is_function(function) do
    function.(value)
    value
  end

  @spec right({any, value}) :: value when value: any
  def right({_left, value}) do
    value
  end

  @spec find_header(list({key, value}), key, default) :: value | default
        when key: String.t(), value: String.t(), default: any
  def find_header(headers, key, default \\ nil) when is_list(headers) and is_binary(key) do
    headers
    |> Enum.find(default, fn {header, _value} -> header == key end)
    |> right()
  end

  @spec prepend(list, any) :: nonempty_maybe_improper_list
  def prepend(list, value) when is_list(list) do
    [value | list]
  end

  @spec flow_logger(Flow.t()) :: Flow.t()
  def flow_logger(flow) do
    flow
    |> Flow.map(fn value ->
      Logger.info(Kernel.inspect(value))
      value
    end)
  end

  @spec flow_logger(Flow.t(), String.t()) :: Flow.t()
  def flow_logger(flow, message) when is_bitstring(message) do
    flow
    |> Flow.map(fn value ->
      Logger.info(message)
      value
    end)
  end

  @spec flow_logger(Flow.t(), (any -> any)) :: Flow.t()
  def flow_logger(flow, function) when is_function(function, 1) do
    flow
    |> Flow.map(fn value ->
      Logger.info(function.(value))
      value
    end)
  end

  @spec enum_logger(Enum.t()) :: Enum.t()
  def enum_logger(enumerable) do
    enumerable
    |> Enum.map(fn value ->
      Logger.info(Kernel.inspect(value))
      value
    end)
  end

  @spec enum_logger(Enum.t(), String.t()) :: Enum.t()
  def enum_logger(enumerable, message) when is_bitstring(message) do
    enumerable
    |> Enum.map(fn value ->
      Logger.info(message)
      value
    end)
  end

  @spec enum_logger(Enum.t(), (any -> any)) :: Enum.t()
  def enum_logger(enumerable, function) when is_function(function, 1) do
    enumerable
    |> Enum.map(fn value ->
      Logger.info(function.(value))
      value
    end)
  end

  @spec cache_fetch(String.t(), (() -> value), integer | nil) ::
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
  def cache_fetch(key, hypothetical, expiration \\ nil)
      when is_bitstring(key) and is_function(hypothetical, 0) do
    Logger.debug("[Cache] Fetching from cache", key: key, expiration: expiration)

    cache_read(key)
    |> case do
      {:ok, nil} -> cache_write(key, hypothetical.(), expiration)
      result -> result
    end
  end

  @spec cache_read(String.t()) ::
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
  def cache_read(key) when is_bitstring(key) do
    Logger.debug("[Cache] Reading from cache", key: key)
    Redix.command(:redix, ["GET", key])
  end

  @spec cache_write(String.t(), any, nil | integer) ::
          {:commit, any}
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
  def cache_write(key, value, nil) when is_bitstring(key) do
    Logger.debug("Writing to cache", key: key)

    Redix.command(:redix, ["SET", key, value])
    |> case do
      {:ok, "OK"} -> {:commit, value}
      result -> result
    end
  end

  def cache_write(key, value, expiration) when is_bitstring(key) and is_integer(expiration) do
    Logger.debug("[Cache] Writing to cache", key: key, expiration: expiration)

    Redix.command(:redix, ["SET", key, value, "PX", expiration])
    |> case do
      {:ok, "OK"} -> {:commit, value}
      result -> result
    end
  end

  @spec cache_erase(bitstring) ::
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
  def cache_erase(key) when is_bitstring(key) do
    Logger.debug("[Cache] Erasing from cache", key: key)
    Redix.command(:redix, ["DEL", key])
  end

  def generate_secret do
    :crypto.strong_rand_bytes(64) |> Base.encode64 |> binary_part(0, 64)
  end
end
