defmodule CoreWeb.Admin.PageControllerTest do
  use CoreWeb.ConnCase

  setup :register_and_log_in_account

  test "GET /admin/", %{conn: conn} do
    conn = get(conn, "/admin/")
    assert html_response(conn, 200) =~ "Core"
  end
end
