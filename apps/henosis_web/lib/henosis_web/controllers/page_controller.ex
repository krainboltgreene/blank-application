defmodule HenosisWeb.PageController do
  use HenosisWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
