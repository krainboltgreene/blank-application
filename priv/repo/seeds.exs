# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Example.Database.Repo.insert!(%Example.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _} =
  %Example.Models.Permission{}
  |> Example.Models.Permission.changeset(%{
    name: "Owner"
  })
  |> Example.Database.Repo.insert()

{:ok, _} =
  %Example.Models.Permission{}
  |> Example.Models.Permission.changeset(%{
    name: "Product Manager"
  })
  |> Example.Database.Repo.insert()

{:ok, _} =
  %Example.Models.Permission{}
  |> Example.Models.Permission.changeset(%{
    name: "Finance Manager"
  })
  |> Example.Database.Repo.insert()

{:ok, _} =
  %Example.Models.Permission{}
  |> Example.Models.Permission.changeset(%{
    name: "Sales Manager"
  })
  |> Example.Database.Repo.insert()
