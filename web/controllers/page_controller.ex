defmodule WebSpa.PageController do
  use WebSpa.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
