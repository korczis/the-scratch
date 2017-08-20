defmodule TheScratch.API.V1.TheScratch.UsersController do
  use TheScratch.Web, :controller

  require Ecto.Query
  require Logger

  alias Ecto.Query
  alias TheScratch.Repo
  alias TheScratch.User

  def index(conn, _params) do
    query = Query.from u in User, select: u.id
    res = Repo.all(query)

    Logger.debug(inspect(res))

    json(conn, res)
  end
end
