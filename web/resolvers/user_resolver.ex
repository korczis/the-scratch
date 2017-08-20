defmodule TheScratch.UserResolver do
  @moduledoc """
  GraphQL Resolver - User
  """

  alias TheScratch.Repo
  alias TheScratch.User

  require Logger

  def find(%{id: id}, _info) do
    {:ok, Repo.get(User, id)}
  end
end
