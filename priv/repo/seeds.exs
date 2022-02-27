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

# Capture the current log level so we can reset after
previous_log_level = Logger.level()

# Change the log level so we don't see all the debug output.
Logger.configure(level: :info)


Core.Users.create_permission(%{
  name: "Administrator"
})

Core.Users.create_permission(%{
  name: "Default"
})

if Mix.env() == "dev" do
  krainboltgreene =
    Core.Users.register_account(%{
      name: "Kurtis Rainbolt-Greene",
      email_address: "kurtis@core.club",
      username: "krainboltgreene",
      password: "password"
    })

  alabaster =
    Core.Users.register_account(%{
      name: "Alabaster Wolf",
      email_address: "alabaster@core.club",
      username: "alabaster",
      password: "password"
    })

  {:ok, _} =
    Core.Users.create_organization(%{
      name: "Default"
    })

  Core.Users.join_organization_by_slug(krainboltgreene, "default", "administrator")
  Core.Users.join_organization_by_slug(alabaster, "default")
end

# Reset the log level back to normal
