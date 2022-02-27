defmodule CoreWeb.AccountRegistrationController do
  use CoreWeb, :controller

  def new(conn, _params) do
    changeset =
      Core.Users.change_account_registration(%Core.Users.Account{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    case Core.Users.register_account(account_params) do
      {:ok, account} ->
        {:ok, _} =
          Core.Users.deliver_account_confirmation_instructions(
            account,
            &Routes.account_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "Account created successfully.")
        |> CoreWeb.AccountAuth.log_in_account(account)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
