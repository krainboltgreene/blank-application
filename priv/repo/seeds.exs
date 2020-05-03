# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ClumsyChinchilla.Database.Repo.insert!(%ClumsyChinchilla.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _} =
  %ClumsyChinchilla.Models.Permission{}
  |> ClumsyChinchilla.Models.Permission.changeset(%{
    name: "Owner"
  })
  |> ClumsyChinchilla.Database.Repo.insert()

{:ok, _} =
  %ClumsyChinchilla.Models.Permission{}
  |> ClumsyChinchilla.Models.Permission.changeset(%{
    name: "Product Manager"
  })
  |> ClumsyChinchilla.Database.Repo.insert()

{:ok, _} =
  %ClumsyChinchilla.Models.Permission{}
  |> ClumsyChinchilla.Models.Permission.changeset(%{
    name: "Finance Manager"
  })
  |> ClumsyChinchilla.Database.Repo.insert()

{:ok, _} =
  %ClumsyChinchilla.Models.Permission{}
  |> ClumsyChinchilla.Models.Permission.changeset(%{
    name: "Sales Manager"
  })
  |> ClumsyChinchilla.Database.Repo.insert()
