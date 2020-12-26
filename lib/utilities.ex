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

  @spec ok_tap({:ok | any, value}, (value -> any())) :: value when value: any
  def ok_tap({:ok, value}, function) when is_function(function) do
    function.(value)
    {:ok, value}
  end

  def ok_tap(touple, _), do: touple

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

  @spec aside_log(list | Flow.t(), bitstring | (any -> any)) :: list | Flow.t()
  def aside_log(list, function) when is_list(list) and is_function(function, 1) do
    list
    |> Enum.map(fn value ->
      Logger.info(function.(value))
      value
    end)
  end

  def aside_log(flow, function) when is_function(function, 1) do
    flow
    |> Flow.map(fn value ->
      Logger.info(function.(value))
      value
    end)
  end

  def aside_log(list, message) when is_list(list) and is_bitstring(message) do
    list
    |> Enum.map(fn value ->
      Logger.info(message)
      value
    end)
  end

  def aside_log(flow, message) when is_bitstring(message) do
    flow
    |> Flow.map(fn value ->
      Logger.info(message)
      value
    end)
  end

  def aside_log(list) when is_list(list) do
    list
    |> Enum.map(fn value ->
      Logger.info(Kernel.inspect(value))
      value
    end)
  end

  def aside_log(flow) do
    flow
    |> Flow.map(fn value ->
      Logger.info(Kernel.inspect(value))
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

  @spec generate_secret :: String.t()
  def generate_secret,
    do: :crypto.strong_rand_bytes(64) |> Base.url_encode64(case: :upper) |> binary_part(0, 64)
end
