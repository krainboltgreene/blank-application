defmodule ClumsyChinchillaWeb.AccountSessionController do
  use ClumsyChinchillaWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"account" => account_params}) do
    %{"email" => email, "password" => password} = account_params

    if account = ClumsyChinchilla.Users.get_account_by_email_and_password(email, password) do
      ClumsyChinchillaWeb.AccountAuth.log_in_account(conn, account, account_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      render(conn, "new.html", error_message: "Invalid email or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> ClumsyChinchillaWeb.AccountAuth.log_out_account()
  end
end
