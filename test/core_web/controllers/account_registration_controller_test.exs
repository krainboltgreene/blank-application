defmodule CoreWeb.AccountRegistrationControllerTest do
  use CoreWeb.ConnCase, async: true

  import Core.UsersFixtures

  describe "GET /accounts/register" do
    test "renders registration page", %{conn: conn} do
      conn = get(conn, Routes.account_registration_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "<h1>Register</h1>"
      assert response =~ "Log in</a>"
      assert response =~ "Register</a>"
    end

    test "redirects if already logged in", %{conn: conn} do
      conn =
        conn
        |> log_in_account(account_fixture())
        |> get(Routes.account_registration_path(conn, :new))

      assert redirected_to(conn) == "/"
    end
  end

  describe "POST /accounts/register" do
    @tag :capture_log
    test "creates account and logs the account in", %{conn: conn} do
      email_address = unique_account_email_address()

      conn =
        post(conn, Routes.account_registration_path(conn, :create), %{
          "account" => valid_account_attributes(email_address: email_address)
        })

      assert get_session(conn, :account_token)
      assert redirected_to(conn) == "/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ email_address
      assert response =~ "Settings</a>"
      assert response =~ "Log out</a>"
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.account_registration_path(conn, :create), %{
          "account" => %{"email_address" => "with spaces", "password" => "too short"}
        })

      response = html_response(conn, 200)
      assert response =~ "<h1>Register</h1>"
      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "should be at least 12 character"
    end
  end
end
