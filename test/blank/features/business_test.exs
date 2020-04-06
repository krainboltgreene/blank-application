defmodule Blank.BusinessTest do
  use Blank.DataCase, async: true
  use BlankWeb.ConnCase

  @endpoint BlankWeb.Endpoint

  describe "business" do
    def create_owner_account() do
      # {:ok, account} = %Blank.Models.Account{}
      # |> Blank.Models.Account.changeset(%{
      #   email: "sally@example.com"
      # })
      # |> Blank.Database.Repo.insert()
      # account

      post(build_conn(), "/graphql", Jason.encode!("
        mutation createAccount($input: NewAccountInput!) {
          createAccount(input: $input) { ... }
        }
      "))
    end

    def found_organization() do
      owner = create_owner_account()

      # owner_permission = Blank.Database.Repo.get_by(Blank.Models.Permission, name: "Owner")

      # assert owner_permission

      # {:ok, organization} = %Blank.Models.Organization{}
      #     |> Blank.Models.Organization.changeset(%{
      #       name: "Hasbro"
      #     })
      #     |> Blank.Database.Repo.insert()
      # {:ok, organization_membership} =
      #   %Blank.Models.OrganizationMembership{}
      #   |> Blank.Models.OrganizationMembership.changeset(%{
      #     account: owner,
      #     organization: organization
      #   })
      #   |> Blank.Database.Repo.insert()
      # {:ok, _} =
      #   %Blank.Models.OrganizationPermission{}
      #   |> Blank.Models.OrganizationPermission.changeset(%{
      #     organization_membership: organization_membership,
      #     permission: owner_permission
      #   })
      #   |> Blank.Database.Repo.insert()
      # assert Enum.member?(
      #     organization
      #       |> Blank.Database.Repo.preload(:accounts)
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
