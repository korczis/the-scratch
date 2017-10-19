defmodule TheScratch.UsersResolver do
  @moduledoc """
  GraphQL Resolver - User
  """

  alias TheScratch.User

  require Logger

  def all(_args, _info) do
    # TODO: Implement (Couchbase)
    user = {}
    {:ok, user}
  end
end
