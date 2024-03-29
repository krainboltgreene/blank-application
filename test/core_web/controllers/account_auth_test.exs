defmodule CoreWeb.CoreWeb.AccountAuthTest do
  use CoreWeb.ConnCase, async: true

  import Core.UsersFixtures

  @remember_me_cookie "_core_web_account_remember_me"

  setup %{conn: conn} do
    conn =
      conn
      |> Map.replace!(:secret_key_base, CoreWeb.Endpoint.config(:secret_key_base))
      |> init_test_session(%{})

    %{account: account_fixture(), conn: conn}
  end

  describe "log_in_account/3" do
    test "stores the account token in the session", %{conn: conn, account: account} do
      conn = CoreWeb.AccountAuth.log_in_account(conn, account)
      assert token = get_session(conn, :account_token)
      assert get_session(conn, :live_socket_id) == "accounts_sessions:#{Base.url_encode64(token)}"
      assert redirected_to(conn) == "/"
      assert Core.Users.get_account_by_session_token(token)
    end

    test "clears everything previously stored in the session", %{conn: conn, account: account} do
      conn =
        conn
        |> put_session(:to_be_removed, "value")
        |> CoreWeb.AccountAuth.log_in_account(account)

      refute get_session(conn, :to_be_removed)
    end

    test "redirects to the configured path", %{conn: conn, account: account} do
      conn =
        conn
        |> put_session(:account_return_to, "/hello")
        |> CoreWeb.AccountAuth.log_in_account(account)

      assert redirected_to(conn) == "/hello"
    end

    test "writes a cookie if remember_me is configured", %{conn: conn, account: account} do
      conn =
        conn
        |> fetch_cookies()
        |> CoreWeb.AccountAuth.log_in_account(account, %{"remember_me" => "true"})

      assert get_session(conn, :account_token) == conn.cookies[@remember_me_cookie]

      assert %{value: signed_token, max_age: max_age} = conn.resp_cookies[@remember_me_cookie]
      assert signed_token != get_session(conn, :account_token)
      assert max_age == 5_184_000
    end
  end

  describe "logout_account/1" do
    test "erases session and cookies", %{conn: conn, account: account} do
      account_token = Core.Users.generate_account_session_token(account)

      conn =
        conn
        |> put_session(:account_token, account_token)
        |> put_req_cookie(@remember_me_cookie, account_token)
        |> fetch_cookies()
        |> CoreWeb.AccountAuth.log_out_account()

      refute get_session(conn, :account_token)
      refute conn.cookies[@remember_me_cookie]
      assert %{max_age: 0} = conn.resp_cookies[@remember_me_cookie]
      assert redirected_to(conn) == "/"
      refute Core.Users.get_account_by_session_token(account_token)
    end

    test "broadcasts to the given live_socket_id", %{conn: conn} do
      live_socket_id = "accounts_sessions:abcdef-token"
      CoreWeb.Endpoint.subscribe(live_socket_id)

      conn
      |> put_session(:live_socket_id, live_socket_id)
      |> CoreWeb.AccountAuth.log_out_account()

      assert_receive %Phoenix.Socket.Broadcast{event: "disconnect", topic: ^live_socket_id}
    end

    test "works even if account is already logged out", %{conn: conn} do
      conn = conn |> fetch_cookies() |> CoreWeb.AccountAuth.log_out_account()
      refute get_session(conn, :account_token)
      assert %{max_age: 0} = conn.resp_cookies[@remember_me_cookie]
      assert redirected_to(conn) == "/"
    end
  end

  describe "fetch_current_account/2" do
    test "authenticates account from session", %{conn: conn, account: account} do
      account_token = Core.Users.generate_account_session_token(account)

      conn =
        conn
        |> put_session(:account_token, account_token)
        |> CoreWeb.AccountAuth.fetch_current_account([])

      assert conn.assigns.current_account.id == account.id
    end

    test "authenticates account from cookies", %{conn: conn, account: account} do
      logged_in_conn =
        conn
        |> fetch_cookies()
        |> CoreWeb.AccountAuth.log_in_account(account, %{"remember_me" => "true"})

      account_token = logged_in_conn.cookies[@remember_me_cookie]
      %{value: signed_token} = logged_in_conn.resp_cookies[@remember_me_cookie]

      conn =
        conn
        |> put_req_cookie(@remember_me_cookie, signed_token)
        |> CoreWeb.AccountAuth.fetch_current_account([])

      assert get_session(conn, :account_token) == account_token
      assert conn.assigns.current_account.id == account.id
    end

    test "does not authenticate if data is missing", %{conn: conn, account: account} do
      _ = Core.Users.generate_account_session_token(account)
      conn = CoreWeb.AccountAuth.fetch_current_account(conn, [])
      refute get_session(conn, :account_token)
      refute conn.assigns.current_account
    end
  end

  describe "redirect_if_account_is_authenticated/2" do
    test "redirects if account is authenticated", %{conn: conn, account: account} do
      conn =
        conn
        |> assign(:current_account, account)
        |> CoreWeb.AccountAuth.redirect_if_account_is_authenticated([])

      assert conn.halted
      assert redirected_to(conn) == "/"
    end

    test "does not redirect if account is not authenticated", %{conn: conn} do
      conn = CoreWeb.AccountAuth.redirect_if_account_is_authenticated(conn, [])
      refute conn.halted
      refute conn.status
    end
  end

  describe "require_authenticated_account/2" do
    test "redirects if account is not authenticated", %{conn: conn} do
      conn = conn |> fetch_flash() |> CoreWeb.AccountAuth.require_authenticated_account([])

      assert conn.halted
      assert redirected_to(conn) == Routes.account_session_path(conn, :new)
      assert get_flash(conn, :error) == "You must log in to access this page."
    end

    test "stores the path to redirect to on GET", %{conn: conn} do
      halted_conn =
        %{conn | path_info: ["foo"], query_string: ""}
        |> fetch_flash()
        |> CoreWeb.AccountAuth.require_authenticated_account([])

      assert halted_conn.halted
      assert get_session(halted_conn, :account_return_to) == "/foo"

      halted_conn =
        %{conn | path_info: ["foo"], query_string: "bar=baz"}
        |> fetch_flash()
        |> CoreWeb.AccountAuth.require_authenticated_account([])

      assert halted_conn.halted
      assert get_session(halted_conn, :account_return_to) == "/foo?bar=baz"

      halted_conn =
        %{conn | path_info: ["foo"], query_string: "bar", method: "POST"}
        |> fetch_flash()
        |> CoreWeb.AccountAuth.require_authenticated_account([])

      assert halted_conn.halted
      refute get_session(halted_conn, :account_return_to)
    end

    test "does not redirect if account is authenticated", %{conn: conn, account: account} do
      conn =
        conn
        |> assign(:current_account, account)
        |> CoreWeb.AccountAuth.require_authenticated_account([])

      refute conn.halted
      refute conn.status
    end
  end
end
