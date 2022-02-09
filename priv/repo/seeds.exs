# Script for populating the database. You can run it as:
#
#     mix run priv/repository/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repo.insert!(%Database.Model.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# Script for populating the database. You can run it as:
#
#     mix run priv/repository/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repo.insert!(%Database.Model.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Database.Models.Permission.create(%{
  name: "Administrator"
})
Database.Models.Permission.create(%{
  name: "Default"
})

krainboltgreene =
  Database.Models.Account.create(%{
    name: "Kurtis Rainbolt-Greene",
    email_address: "kurtis@clumsy-chinchilla.club",
    username: "krainboltgreene",
    password: "password"
  })
alabaster =
  Database.Models.Account.create(%{
    name: "Alabaster Wolf",
    email_address: "alabaster@clumsy-chinchilla.club",
    username: "alabaster",
    password: "password"
  })

{:ok, _} =
  Database.Models.Organization.create(%{
    name: "Default"
  })

Core.Organization.join(krainboltgreene, "default", "administrator")
Core.Organization.join(alabaster, "default")
