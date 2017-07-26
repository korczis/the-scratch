defmodule TheScratch.PageController do
  use TheScratch.Web, :controller

  def index(conn, _params) do
     render conn, "index.html"
  end
end
