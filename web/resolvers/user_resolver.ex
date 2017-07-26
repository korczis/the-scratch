defmodule TheScratch.UserResolver do
  alias TheScratch.Repo
  alias TheScratch.User

  def all(_args, _info) do
    {:ok, Repo.all(User)}
  end
end