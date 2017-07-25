defmodule WebSpa.PageController do
  use WebSpa.Web, :controller

  def index(conn, _params) do
    conn
      |> render "index.html"
  end
end
