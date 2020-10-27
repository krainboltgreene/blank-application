# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repository.insert!(%ClumsyChinchilla.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LittleBlackBook.Database.Repository.insert!(%LittleBlackBook.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  def create_record(attributes, model, repository \\ LittleBlackBook.Database.Repository) do
    struct(model)
    |> model.changeset(attributes)
    |> repository.insert()
    |> case do
      {:ok, record} -> record
      {:error, _} = exception -> exception
    end
  end

  def assign_membership(account, organization, permission) do
    %{
      organization_membership:
        %{
          account: account,
          organization: organization
        }
        |> create_record(LittleBlackBook.Models.OrganizationMembership),
      permission: permission
    }
    |> create_record(LittleBlackBook.Models.OrganizationPermission)
  end
end

administrator_permissions =
  %{
    name: "Administrator"
  }
  |> Seeds.create_record(LittleBlackBook.Models.Permission)

dater_permissions =
  %{
    name: "Dater"
  }
  |> Seeds.create_record(LittleBlackBook.Models.Permission)

users_organization =
  %{
    name: "Users"
  }
  |> Seeds.create_record(LittleBlackBook.Models.Organization)

krainboltgreene =
  %{
    name: "Kurtis Rainbolt-Greene",
    email_address: "kurtis@clumsy-chinchilla.club",
    username: "krainboltgreene",
    password: "password"
  }
  |> Seeds.create_record(LittleBlackBook.Models.Account)

dinkums =
  %{
    name: "Dinom Fark",
    email_address: "dinkums@clumsy-chinchilla.club",
    username: "dinkums",
    password: "password2"
  }
  |> Seeds.create_record(LittleBlackBook.Models.Account)

flirk =
  %{
    name: "Alabaster Wolf",
    email_address: "flirk@clumsy-chinchilla.club",
    username: "flirk",
    password: "password"
  }
  |> Seeds.create_record(LittleBlackBook.Models.Account)

krainboltgreene |> Seeds.assign_membership(users_organization, administrator_permissions)
dinkums |> Seeds.assign_membership(users_organization, administrator_permissions)
flirk |> Seeds.assign_membership(users_organization, dater_permissions)
