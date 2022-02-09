defmodule ClumsyChinchilla.Users do
  @spec join(ClumsyChinchilla.Users.Account.t(), String.t()) ::
          {:ok, ClumsyChinchilla.Users.Organization.t()}
          | {:error,
             :not_found | Ecto.Changeset.t(ClumsyChinchilla.Users.OrganizationPermission.t())}
  def join(account, organization_slug) do
    join(account, organization_slug, "default")
  end
  @spec join(ClumsyChinchilla.Users.Account.t(), String.t(), String.t()) ::
          {:ok, ClumsyChinchilla.Users.Organization.t()}
          | {:error,
             :not_found | Ecto.Changeset.t(ClumsyChinchilla.Users.OrganizationPermission.t())}
  def join(account, organization_slug, permission_slug) do
    ClumsyChinchilla.Users.Organization
      |> ClumsyChinchilla.Repo.get_by(%{slug: organization_slug})
      |> case do
        nil -> {:error, :not_found}
        organization -> ClumsyChinchilla.Users.Permission
          |> ClumsyChinchilla.Repo.get_by(%{slug: permission_slug})
          |> case do
            nil -> {:error, :not_found}
            permission -> {:ok, {organization, permission}}
          end
      end
      |> case do
        {:ok, {organization, permission}} ->
          ClumsyChinchilla.Users.create_organization_membership(%{
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
          ClumsyChinchilla.Users.create_organization_permission(%{
            organization_membership: organization_membership,
            permission: permission
          })
        error -> error
      end
  end
end
