# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Core.Repo.insert!(%Core.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Core.Users.create_permission(%{
  name: "Administrator"
})

Core.Users.create_permission(%{
  name: "Default"
})

krainboltgreene =
  Core.Users.register_account(%{
    name: "Kurtis Rainbolt-Greene",
    email_address: "kurtis@clumsy-chinchilla.club",
    username: "krainboltgreene",
    password: "password"
  })

alabaster =
  Core.Users.register_account(%{
    name: "Alabaster Wolf",
    email_address: "alabaster@clumsy-chinchilla.club",
    username: "alabaster",
    password: "password"
  })

{:ok, _} =
  Core.Users.create_organization(%{
    name: "Default"
  })

Core.Users.join_organiztion(krainboltgreene, "default", "administrator")
Core.Users.join_organiztion(alabaster, "default")
