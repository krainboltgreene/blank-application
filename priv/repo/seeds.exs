# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repo.insert!(%ClumsyChinchilla.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _} =
  %Database.Models.Permission{}
  |> Database.Models.Permission.changeset(%{
    name: "Owner"
  })
  |> Database.Repo.insert()

{:ok, _} =
  %Database.Models.Permission{}
  |> Database.Models.Permission.changeset(%{
    name: "Product Manager"
  })
  |> Database.Repo.insert()

{:ok, _} =
  %Database.Models.Permission{}
  |> Database.Models.Permission.changeset(%{
    name: "Finance Manager"
  })
  |> Database.Repo.insert()

{:ok, _} =
  %Database.Models.Permission{}
  |> Database.Models.Permission.changeset(%{
    name: "Sales Manager"
  })
  |> Database.Repo.insert()
