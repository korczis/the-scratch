defmodule TheScratch.UserResolver do
  @moduledoc """
  GraphQL Resolver - User
  """

  alias TheScratch.Repo
  alias TheScratch.User

  require Logger

  def all(args, info) do
    Logger.info inspect(args)
    Logger.info inspect(info)

    {:ok, Repo.all(User)}
  end
end
