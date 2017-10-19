defmodule TheScratch.API.V1.TheScratch.UsersController do
  use TheScratch.Web, :controller

  require Logger

  alias TheScratch.Proto.User

  def index(conn, _params) do
    # TODO: Implement (Couchbase)

    json(conn, [])
  end
end
