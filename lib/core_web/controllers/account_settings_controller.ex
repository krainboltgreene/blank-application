defmodule CoreWeb.AccountSettingsController do
  use CoreWeb, :controller

  plug :assign_email_address_and_password_changesets

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  def update(conn, %{"action" => "update_email_address"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    account = conn.assigns.current_account

    case Core.Users.apply_account_email_address(account, password, account_params) do
      {:ok, applied_account} ->
        Core.Users.deliver_update_email_address_instructions(
          applied_account,
          account.email_address,
          &Routes.account_settings_url(conn, :confirm_email_address, &1)
        )

        conn
        |> put_flash(
          :info,
          "A link to confirm your email change has been sent to the new address."
        )
        |> redirect(to: Routes.account_settings_path(conn, :edit))

      {:error, changeset} ->
        render(conn, "edit.html", email_address_changeset: changeset)
    end
  end

  def update(conn, %{"action" => "update_password"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    account = conn.assigns.current_account

    case Core.Users.update_account_password(account, password, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Password updated successfully.")
        |> put_session(:account_return_to, Routes.account_settings_path(conn, :edit))
        |> CoreWeb.AccountAuth.log_in_account(account)

      {:error, changeset} ->
        render(conn, "edit.html", password_changeset: changeset)
    end
  end

  def confirm_email_address(conn, %{"token" => token}) do
    case Core.Users.update_account_email_address(conn.assigns.current_account, token) do
      :ok ->
        conn
        |> put_flash(:info, "Email changed successfully.")
        |> redirect(to: Routes.account_settings_path(conn, :edit))

      :error ->
        conn
        |> put_flash(:error, "Email change link is invalid or it has expired.")
        |> redirect(to: Routes.account_settings_path(conn, :edit))
    end
  end

  defp assign_email_address_and_password_changesets(conn, _opts) do
    account = conn.assigns.current_account

    conn
    |> assign(
      :email_address_changeset,
      Core.Users.change_account_email_address(account)
    )
    |> assign(:password_changeset, Core.Users.change_account_password(account))
  end
end
