defmodule TheScratch.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias TheScratch.Repo
  alias TheScratch.User

  import Logger

  def for_token(user = %User{}) do
    { :ok, %{id: user.id, email: user.email, provider: user.provider} }
  end

  def for_token(_) do
    { :error, "Unknown resource type" }
  end

  def from_token(user) do
    { :ok, %User{id: Map.fetch!(user, "id"), email: Map.fetch!(user, "email"), provider: Map.fetch!(user, "provider") } }
  end

end
