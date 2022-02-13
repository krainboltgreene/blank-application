defmodule ClumsyChinchillaWeb.AccountRegistrationController do
  use ClumsyChinchillaWeb, :controller

  def new(conn, _params) do
    changeset = ClumsyChinchilla.Users.change_account_registration(%ClumsyChinchilla.Users.Account{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    case ClumsyChinchilla.Users.register_account(account_params) do
      {:ok, account} ->
        {:ok, _} =
          ClumsyChinchilla.Users.deliver_account_confirmation_instructions(
            account,
            &Routes.account_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "Account created successfully.")
        |> ClumsyChinchillaWeb.AccountAuth.log_in_account(account)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
