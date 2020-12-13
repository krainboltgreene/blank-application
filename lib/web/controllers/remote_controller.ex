defmodule ClumsyChinchillaWeb.RemoteController do
  use ClumsyChinchillaWeb, :controller

  def browser_remote(conn, _) do
    redirect(conn, to: "/")
  end
end
