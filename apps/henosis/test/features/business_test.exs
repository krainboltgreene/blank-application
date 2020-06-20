defmodule Henosis.BusinessTest do
  use Henosis.DataCase, async: true
  use HenosisWeb.ConnCase

  @endpoint HenosisWeb.Endpoint

  describe "business" do
    def create_owner_account() do
      # {:ok, account} = %Henosis.Models.Account{}
      # |> Henosis.Models.Account.changeset(%{
      #   email: "sally@henosis.com"
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

      # owner_permission = Database.Repo.get_by(Henosis.Models.Permission, name: "Owner")

      # assert owner_permission

      # {:ok, organization} = %Henosis.Models.Organization{}
      #     |> Henosis.Models.Organization.changeset(%{
      #       name: "Hasbro"
      #     })
      #     |> Database.Repo.insert()
      # {:ok, organization_membership} =
      #   %Henosis.Models.OrganizationMembership{}
      #   |> Henosis.Models.OrganizationMembership.changeset(%{
      #     account: owner,
      #     organization: organization
      #   })
      #   |> Database.Repo.insert()
      # {:ok, _} =
      #   %Henosis.Models.OrganizationPermission{}
      #   |> Henosis.Models.OrganizationPermission.changeset(%{
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
