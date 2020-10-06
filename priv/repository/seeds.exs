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
      organization_membership: %{
        account: account,
        organization: organization
      } |> create_record(LittleBlackBook.Models.OrganizationMembership),
      permission: permission
    } |> create_record(LittleBlackBook.Models.OrganizationPermission)
  end
end

administrator_permissions = %{
  name: "Administrator"
} |> Seeds.create_record(LittleBlackBook.Models.Permission)

dater_permissions = %{
  name: "Dater"
} |> Seeds.create_record(LittleBlackBook.Models.Permission)

users_organization = %{
  name: "Users"
} |> Seeds.create_record(LittleBlackBook.Models.Organization)

krainboltgreene = %{
  name: "Kurtis Rainbolt-Greene",
  email: "kurtis@difference-engineers.com",
  username: "krainboltgreene",
  password: "password"
} |> Seeds.create_record(LittleBlackBook.Models.Account)

emash = %{
  name: "Emily Ashley",
  email: "ohemilyashley@gmail.com",
  username: "emash",
  password: "password2"
} |> Seeds.create_record(LittleBlackBook.Models.Account)

alabaster = %{
  name: "Alabaster Wolf",
  email: "dinguspaz@gmail.com",
  username: "alabaster",
  password: "password"
} |> Seeds.create_record(LittleBlackBook.Models.Account)

krainboltgreene |> Seeds.assign_membership(users_organization, administrator_permissions)
emash |> Seeds.assign_membership(users_organization, administrator_permissions)
alabaster |> Seeds.assign_membership(users_organization, dater_permissions)
