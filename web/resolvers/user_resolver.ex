defmodule TheScratch.UserResolver do
  @moduledoc """
  GraphQL Resolver - User
  """

  alias TheScratch.User

  require Logger

  def find(%{id: id}, _info) do
    # TODO: Implement (Couchbase)
    user = {}
    {:ok, user}
  end
end
