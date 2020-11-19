defmodule Database.Models.AccountTest do
  @moduledoc false
  use Database.DataCase
  doctest Database.Models.Account

  test "changeset returns valid changeset with minimum data" do
    Database.Models.Account.__struct__()
    |> Database.Models.Account.changeset(%{
      email_address: "kurtis@example.com",
      settings: %{light_mode: false}
    })
    |> Map.get(:valid?)
    |> assert()
  end
end
