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

ClumsyChinchilla.Users.create_permission(%{
  name: "Administrator"
})

ClumsyChinchilla.Users.create_permission(%{
  name: "Default"
})

krainboltgreene =
  ClumsyChinchilla.Users.register_account(%{
    name: "Kurtis Rainbolt-Greene",
    email_address: "kurtis@clumsy-chinchilla.club",
    username: "krainboltgreene",
    password: "password"
  })

alabaster =
  ClumsyChinchilla.Users.register_account(%{
    name: "Alabaster Wolf",
    email_address: "alabaster@clumsy-chinchilla.club",
    username: "alabaster",
    password: "password"
  })

{:ok, _} =
  ClumsyChinchilla.Users.create_organization(%{
    name: "Default"
  })

ClumsyChinchilla.Users.join_organiztion(krainboltgreene, "default", "administrator")
ClumsyChinchilla.Users.join_organiztion(alabaster, "default")
