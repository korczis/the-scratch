defmodule TheScratch.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  require Logger
  require Ecto.Query

  alias Ecto.Query
  alias Guardian.Plug
  alias TheScratch.Repo
  alias TheScratch.User

  use TheScratch.Web, :controller
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    provider = Map.fetch!(params, "provider")
    user = auth.extra.raw_info.user
    email = Map.fetch!(user, "email")

    query = Query.from u in User,
      where: u.provider == ^provider and u.email == ^email

    user = case Repo.one(query) do
      nil -> {
        case Repo.insert %User{email: email, provider: provider, profile: user} do
          {:ok, u} -> u
          _ -> nil
        end
      }
      u -> u
    end

    { :ok, jwt, _ } = Guardian.encode_and_sign(user)
    Logger.debug "JWT: #{jwt}"

    conn
    |> Plug.sign_in(user, jwt)
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> redirect(to: "/#/")
  end

  def user(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    case user do
      %User{email: email} -> json(conn, %{email: "korczis@gmail.com"})
      _ -> json(conn, nil)
    end


  end

  def sign_out(conn, _params) do
      Guardian.Plug.sign_out(conn)
      |> clear_session
      |> redirect(to: "/")
    end
end
