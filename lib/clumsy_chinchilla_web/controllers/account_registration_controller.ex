defmodule ClumsyChinchillaWeb.AccountRegistrationController do
  use ClumsyChinchillaWeb, :controller

  alias ClumsyChinchilla.User
  alias ClumsyChinchilla.User.Account
  alias ClumsyChinchillaWeb.AccountAuth

  def new(conn, _params) do
    changeset = User.change_account_registration(%Account{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    case User.register_account(account_params) do
      {:ok, account} ->
        {:ok, _} =
          User.deliver_account_confirmation_instructions(
            account,
            &Routes.account_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "Account created successfully.")
        |> AccountAuth.log_in_account(account)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
