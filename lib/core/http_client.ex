defmodule Core.HTTPClient do
  @type client_errors :: {:error, :missing_body | Jason.DecodeError.t | Mint.HTTPError.t | Mint.TransportError.t}
  @cache_directory "tmp"

  @spec fetch(:community | :league, String.t) :: {:ok, term} | client_errors
  def fetch(owner, uri) do
    if File.exists?("#{@cache_directory}/#{owner}/#{checksum(uri)}") do
      File.read("#{@cache_directory}/#{owner}/#{checksum(uri)}")
    else
      Finch.build(:get, uri)
      |> Finch.request(Core.HTTPClient)
      |> case do
        {:ok, response} -> {:ok, Map.get(response, :body, nil)}
        error -> error
      end
      |> case do
        {:ok, nil} -> {:error, :missing_body}
        {:ok, body} ->
          File.write("#{@cache_directory}/#{owner}/#{checksum(uri)}", body)
          |> case do
            :ok -> {:ok, body}
            error -> error
          end
        error -> error
      end
    end
    |> case do
      {:ok, body} -> Jason.decode(body)
      error -> error
    end
  end

  defp checksum(content) do
    :crypto.hash(:sha256, content) |> Base.encode16
  end
end
