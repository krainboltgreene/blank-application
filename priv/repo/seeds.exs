# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ClumsyChinchilla.Repo.insert!(%ClumsyChinchilla.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

ClumsyChinchilla.Users.Permission.create(%{
  name: "Administrator"
})
ClumsyChinchilla.Users.Permission.create(%{
  name: "Default"
})

krainboltgreene =
  ClumsyChinchilla.Users.Account.create(%{
    name: "Kurtis Rainbolt-Greene",
    email_address: "kurtis@clumsy-chinchilla.club",
    username: "krainboltgreene",
    password: "password"
  })
alabaster =
  ClumsyChinchilla.Users.Account.create(%{
    name: "Alabaster Wolf",
    email_address: "alabaster@clumsy-chinchilla.club",
    username: "alabaster",
    password: "password"
  })

{:ok, _} =
  ClumsyChinchilla.Users.Organization.create(%{
    name: "Default"
  })

ClumsyChinchilla.Users.join_organiztion(krainboltgreene, "default", "administrator")
ClumsyChinchilla.Users.join_organiztion(alabaster, "default")
