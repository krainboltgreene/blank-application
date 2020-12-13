defmodule Web.RemoteController do
  use Web, :controller

  def browser_remote(conn, _) do
    redirect(conn, to: "/")
  end
end
