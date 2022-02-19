defmodule ClumsyChinchillaWeb.AccountConfirmationController do
  use ClumsyChinchillaWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"account" => %{"email_address" => email_address}}) do
    if account = ClumsyChinchilla.Users.get_account_by_email_address(email_address) do
      ClumsyChinchilla.Users.deliver_account_confirmation_instructions(
        account,
        &Routes.account_confirmation_url(conn, :edit, &1)
      )
    end

    conn
    |> put_flash(
      :info,
      "If your email is in our system and it has not been confirmed yet, " <>
        "you will receive an email with instructions shortly."
    )
    |> redirect(to: "/")
  end

  def edit(conn, %{"token" => token}) do
    render(conn, "edit.html", token: token)
  end

  # Do not log in the account after confirmation to avoid a
  # leaked token giving the account access to the account.
  def update(conn, %{"token" => token}) do
    case ClumsyChinchilla.Users.confirm_account(token) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account confirmed successfully.")
        |> redirect(to: "/")

      :error ->
        # If there is a current account and the account was already confirmed,
        # then odds are that the confirmation link was already visited, either
        # by some automation or by the account themselves, so we redirect without
        # a warning message.
        case conn.assigns do
          %{current_account: %{confirmed_at: confirmed_at}} when not is_nil(confirmed_at) ->
            redirect(conn, to: "/")

          %{} ->
            conn
            |> put_flash(:error, "Account confirmation link is invalid or it has expired.")
            |> redirect(to: "/")
        end
    end
  end
end
