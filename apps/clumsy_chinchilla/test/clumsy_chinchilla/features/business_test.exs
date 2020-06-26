defmodule ClumsyChinchilla.BusinessTest do
  use ClumsyChinchilla.DataCase, async: true
  use ClumsyChinchillaWeb.ConnCase

  @endpoint ClumsyChinchillaWeb.Endpoint

  describe "business" do
    def create_owner_account() do
      # {:ok, account} = %Database.Models.Account{}
      # |> Database.Models.Account.changeset(%{
      #   email: "sally@clumsy_chinchilla.com"
      # })
      # |> Database.Repo.insert()
      # account

      post(build_conn(), "/graphql", Jason.encode!("
        mutation createAccount($input: NewAccountInput!) {
          createAccount(input: $input) { ... }
        }
      "))
    end

    def found_organization() do
      owner = create_owner_account()

      # owner_permission = Database.Repo.get_by(Database.Models.Permission, name: "Owner")

      # assert owner_permission

      # {:ok, organization} = %Database.Models.Organization{}
      #     |> Database.Models.Organization.changeset(%{
      #       name: "Hasbro"
      #     })
      #     |> Database.Repo.insert()
      # {:ok, organization_membership} =
      #   %Database.Models.OrganizationMembership{}
      #   |> Database.Models.OrganizationMembership.changeset(%{
      #     account: owner,
      #     organization: organization
      #   })
      #   |> Database.Repo.insert()
      # {:ok, _} =
      #   %Database.Models.OrganizationPermission{}
      #   |> Database.Models.OrganizationPermission.changeset(%{
      #     organization_membership: organization_membership,
      #     permission: owner_permission
      #   })
      #   |> Database.Repo.insert()
      # assert Enum.member?(
      #     organization
      #       |> Database.Repo.preload(:accounts)
      #       |> Map.fetch!(:accounts),
      #     owner
      #   )
      # organization
    end

    test "works" do
      renraku = found_organization()
    end
  end
end
