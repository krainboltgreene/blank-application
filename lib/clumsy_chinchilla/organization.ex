defmodule Core.Organization do
  @spec join(Database.Models.Account.t(), String.t()) ::
          {:ok, Database.Models.Organization.t()}
          | {:error,
             :not_found | Ecto.Changeset.t(Database.Models.OrganizationPermission.t())}
  def join(account, organization_slug) do
    join(account, organization_slug, "default")
  end
  @spec join(Database.Models.Account.t(), String.t(), String.t()) ::
          {:ok, Database.Models.Organization.t()}
          | {:error,
             :not_found | Ecto.Changeset.t(Database.Models.OrganizationPermission.t())}
  def join(account, organization_slug, permission_slug) do
    Database.Models.Organization
      |> Database.Repo.get_by(%{slug: organization_slug})
      |> case do
        nil -> {:error, :not_found}
        organization -> Database.Models.Permission
          |> Database.Repo.get_by(%{slug: permission_slug})
          |> case do
            nil -> {:error, :not_found}
            permission -> {:ok, {organization, permission}}
          end
      end
      |> case do
        {:ok, {organization, permission}} ->
          Database.Models.OrganizationMembership.create(%{
            organization: organization,
            account: account
          })
          |> case do
            {:ok, organization_membership} -> {:ok, {organization_membership, permission}}
            error -> error
          end
        error -> error
      end
      |> case do
        {:ok, {organization_membership, permission}} ->
          Database.Models.OrganizationPermission.create(%{
            organization_membership: organization_membership,
            permission: permission
          })
        error -> error
      end
  end
end
