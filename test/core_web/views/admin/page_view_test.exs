defmodule CoreWeb.Admin.PageViewTest do
  use CoreWeb.ConnCase, async: true
  doctest CoreWeb.Admin.PageView

  test "render()" do
    assert is_struct(
             CoreWeb.Admin.PageView.render("index.html"),
             Phoenix.LiveView.Rendered
           )
  end
end
