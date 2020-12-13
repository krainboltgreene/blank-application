# Script for populating the database. You can run it as:
#
#     mix run priv/repository/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repository.insert!(%Database.Model.SomeSchema{})
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
#     Database.Repository.insert!(%Database.Model.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  @moduledoc false
  def create_record(attributes, model) do
    struct(model)
    |> model.changeset(attributes)
    |> Database.Repository.insert!()
  end

  def assign_membership(account, organization, permission) do
    %{
      organization_membership:
        %{
          account: account,
          organization: organization
        }
        |> create_record(Database.Models.OrganizationMembership),
      permission: permission
    }
    |> create_record(Database.Models.OrganizationPermission)
  end
end

administrator_permissions =
  %{
    name: "Administrator"
  }
  |> Seeds.create_record(Database.Models.Permission)

dater_permissions =
  %{
    name: "Dater"
  }
  |> Seeds.create_record(Database.Models.Permission)

users_organization =
  %{
    name: "Users"
  }
  |> Seeds.create_record(Database.Models.Organization)

krainboltgreene =
  %{
    name: "Kurtis Rainbolt-Greene",
    email_address: "kurtis@clumsy-chinchilla.club",
    username: "krainboltgreene",
    password: "password"
  }
  |> Seeds.create_record(Database.Models.Account)

alabaster =
  %{
    name: "Alabaster Wolf",
    email_address: "alabaster@clumsy-chinchilla.club",
    username: "alabaster",
    password: "password"
  }
  |> Seeds.create_record(Database.Models.Account)

krainboltgreene |> Seeds.assign_membership(users_organization, administrator_permissions)
alabaster |> Seeds.assign_membership(users_organization, dater_permissions)
