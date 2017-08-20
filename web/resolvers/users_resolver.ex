defmodule TheScratch.UsersResolver do
  @moduledoc """
  GraphQL Resolver - User
  """

  alias TheScratch.Repo
  alias TheScratch.User

  require Logger

  def all(_args, _info) do
    {:ok, Repo.all(User)}
  end
end
