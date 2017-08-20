defmodule TheScratch.UsersResolver do
  @moduledoc """
  GraphQL Resolver - User
  """

  alias TheScratch.Repo
  alias TheScratch.User

  require Logger

  def all(args, info) do
    {:ok, Repo.all(User)}
  end
end
