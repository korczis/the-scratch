defmodule TheScratch.Router do
  use TheScratch.Web, :router

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
    plug Guardian.Plug.LoadResource
  end

  pipeline :graphql do
    plug :fetch_cookies
  end

  scope "/auth", TheScratch do
    pipe_through [:browser, :browser_session]

    get "/user", AuthController, :user
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback

    post "/signout", AuthController, :sign_out
  end

  scope "/api/v1", as: :api_v1, alias: TheScratch.API.V1 do
    pipe_through :api

    get "/users", TheScratch.UsersController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", TheScratch do
    pipe_through :api
  end

  scope "/graphql" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: TheScratch.Schema
  end

  scope "/graphiql" do
    pipe_through :graphql

    get "/", Absinthe.Plug.GraphiQL, schema: TheScratch.Schema
    post "/", Absinthe.Plug.GraphiQL, schema: TheScratch.Schema
  end

  scope "/", TheScratch do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    get "/*path", PageController, :index
  end

end
