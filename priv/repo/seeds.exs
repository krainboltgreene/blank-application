# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blank.Database.Repo.insert!(%Blank.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _} =
  %Blank.Models.Permission{}
  |> Blank.Models.Permission.changeset(%{
    name: "Owner"
  })
  |> Blank.Database.Repo.insert()

{:ok, _} =
  %Blank.Models.Permission{}
  |> Blank.Models.Permission.changeset(%{
    name: "Product Manager"
  })
  |> Blank.Database.Repo.insert()

{:ok, _} =
  %Blank.Models.Permission{}
  |> Blank.Models.Permission.changeset(%{
    name: "Finance Manager"
  })
  |> Blank.Database.Repo.insert()

{:ok, _} =
  %Blank.Models.Permission{}
  |> Blank.Models.Permission.changeset(%{
    name: "Sales Manager"
  })
  |> Blank.Database.Repo.insert()
