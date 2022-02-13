defmodule ClumsyChinchillaWeb.PageController do
  use ClumsyChinchillaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
