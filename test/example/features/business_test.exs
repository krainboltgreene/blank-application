defmodule Example.BusinessTest do
  use Example.DataCase, async: true
  use ExampleWeb.ConnCase

  @endpoint ExampleWeb.Endpoint

  describe "business" do
    def create_owner_account() do
      # {:ok, account} = %Example.Models.Account{}
      # |> Example.Models.Account.changeset(%{
      #   email: "sally@example.com"
      # })
      # |> Example.Database.Repo.insert()
      # account

      post(build_conn(), "/graphql", Jason.encode!("
        mutation createAccount($input: NewAccountInput!) {
          createAccount(input: $input) { ... }
        }
      "))
    end

    def found_organization() do
      owner = create_owner_account()

      # owner_permission = Example.Database.Repo.get_by(Example.Models.Permission, name: "Owner")

      # assert owner_permission

      # {:ok, organization} = %Example.Models.Organization{}
      #     |> Example.Models.Organization.changeset(%{
      #       name: "Hasbro"
      #     })
      #     |> Example.Database.Repo.insert()
      # {:ok, organization_membership} =
      #   %Example.Models.OrganizationMembership{}
      #   |> Example.Models.OrganizationMembership.changeset(%{
      #     account: owner,
      #     organization: organization
      #   })
      #   |> Example.Database.Repo.insert()
      # {:ok, _} =
      #   %Example.Models.OrganizationPermission{}
      #   |> Example.Models.OrganizationPermission.changeset(%{
      #     organization_membership: organization_membership,
      #     permission: owner_permission
      #   })
      #   |> Example.Database.Repo.insert()
      # assert Enum.member?(
      #     organization
      #       |> Example.Database.Repo.preload(:accounts)
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
