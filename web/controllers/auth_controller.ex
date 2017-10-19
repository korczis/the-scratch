defmodule TheScratch.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  require Logger

  alias Guardian.Plug
  alias TheScratch.Proto.User

  use TheScratch.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    provider = Map.fetch!(params, "provider")
    user = auth.extra.raw_info.user
    email = Map.fetch!(user, "email")
    user_id = Map.fetch!(user, "id")

    id = "user.#{provider}.#{user_id}"

    # TODO: Implement (Couchbase)
    user = %User{
      id: id,
      email: email,
      provider: provider,
    #  profile: user
    }

    TheScratch.Couchbase.upsert(id, user)

#    query = Query.from u in User,
#      where: u.provider == ^provider and u.email == ^email
#
#    user = case Repo.one(query) do
#      nil -> {
#        case Repo.insert %User{
#          email: email,
#          provider: provider,
#          profile: user
#        } do
#          {:ok, u} -> u
#          _ -> nil
#        end
#      }
#      u -> u
#    end

    {:ok, jwt, _} = Guardian.encode_and_sign(user)

    conn
      |> Plug.sign_in(user, jwt)
      |> put_resp_header("authorization", "Bearer #{jwt}")
      |> redirect(to: "/#/")
  end

  def user(conn, _params) do
    user = Plug.current_resource(conn)
    case user do
      %User{id: id, email: email, provider: provider} ->
        conn
          |> put_resp_header("jwt", Plug.current_token(conn))
          |> json(%{
            id: id,
            email: email,
            provider: provider
          })
      _ -> json(conn, nil)
    end
  end

  def sign_out(conn, _params) do
    conn
      |> Plug.sign_out
      |> clear_session
      |> redirect(to: "/")
    end
end
