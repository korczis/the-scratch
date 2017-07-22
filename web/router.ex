defmodule WebSpa.Router do
  use WebSpa.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/auth", WebSpa do
    pipe_through [:browser, :browser_session]

    get "/user", AuthController, :user
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/api/v1", as: :api_v1, alias: WebSpa.API.V1 do
    pipe_through :api
  end

  scope "/", WebSpa do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", WebSpa do
    pipe_through :api
  end
end
