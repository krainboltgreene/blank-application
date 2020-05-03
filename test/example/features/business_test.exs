defmodule ClumsyChinchilla.BusinessTest do
  use ClumsyChinchilla.DataCase, async: true
  use ClumsyChinchillaWeb.ConnCase

  @endpoint ClumsyChinchillaWeb.Endpoint

  describe "business" do
    def create_owner_account() do
      # {:ok, account} = %ClumsyChinchilla.Models.Account{}
      # |> ClumsyChinchilla.Models.Account.changeset(%{
      #   email: "sally@clumsy-chinchilla.com"
      # })
      # |> ClumsyChinchilla.Database.Repo.insert()
      # account

      post(build_conn(), "/graphql", Jason.encode!("
        mutation createAccount($input: NewAccountInput!) {
          createAccount(input: $input) { ... }
        }
      "))
    end

    def found_organization() do
      owner = create_owner_account()

      # owner_permission = ClumsyChinchilla.Database.Repo.get_by(ClumsyChinchilla.Models.Permission, name: "Owner")

      # assert owner_permission

      # {:ok, organization} = %ClumsyChinchilla.Models.Organization{}
      #     |> ClumsyChinchilla.Models.Organization.changeset(%{
      #       name: "Hasbro"
      #     })
      #     |> ClumsyChinchilla.Database.Repo.insert()
      # {:ok, organization_membership} =
      #   %ClumsyChinchilla.Models.OrganizationMembership{}
      #   |> ClumsyChinchilla.Models.OrganizationMembership.changeset(%{
      #     account: owner,
      #     organization: organization
      #   })
      #   |> ClumsyChinchilla.Database.Repo.insert()
      # {:ok, _} =
      #   %ClumsyChinchilla.Models.OrganizationPermission{}
      #   |> ClumsyChinchilla.Models.OrganizationPermission.changeset(%{
      #     organization_membership: organization_membership,
      #     permission: owner_permission
      #   })
      #   |> ClumsyChinchilla.Database.Repo.insert()
      # assert Enum.member?(
      #     organization
      #       |> ClumsyChinchilla.Database.Repo.preload(:accounts)
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
