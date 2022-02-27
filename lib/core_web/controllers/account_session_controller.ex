defmodule CoreWeb.AccountSessionController do
  use CoreWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"account" => account_params}) do
    %{"email_address" => email_address, "password" => password} = account_params

    if account =
         Core.Users.get_account_by_email_address_and_password(email_address, password) do
      CoreWeb.AccountAuth.log_in_account(conn, account, account_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      render(conn, "new.html", error_message: "Invalid email or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> CoreWeb.AccountAuth.log_out_account()
  end
end
