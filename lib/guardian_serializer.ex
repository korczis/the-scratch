defmodule TheScratch.GuardianSerializer do
  @moduledoc """
  Guardian Serializer
  """

  @behaviour Guardian.Serializer

  alias TheScratch.Proto.User

  def for_token(%User{} = user) do
    {:ok, %{id: user.id, email: user.email, provider: user.provider}}
  end

  def for_token(_) do
    {:error, "Unknown resource type"}
  end

  def from_token(user) do
    res_user = %User{
      id: Map.fetch!(user, "id"),
      email: Map.fetch!(user, "email"),
      provider: Map.fetch!(user, "provider")
    }

    {:ok, res_user}
  end
end
