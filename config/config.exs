# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :gauc, Gauc,
       url: "couchbase://localhost/default",
       username: "Administrator",
       password: "Administrator",
       pool: [
         size: 4,
         max_overflow: 8
       ]

# Configures the endpoint
config :the_scratch, TheScratch.Endpoint,
       url: [host: "localhost"],
       secret_key_base: "Rp0yPLkzzx5Derw7c65Qx71W2M6IOsgkh+eqBtnEGls7Yfw6FwrVAvxV/RjeRlP2",
       render_errors: [view: TheScratch.ErrorView, accepts: ~w(html json)],
       pubsub: [name: TheScratch.PubSub,
         adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

config :guardian, Guardian,
       allowed_algos: ["HS512"], # optional
       verify_module: Guardian.JWT,  # optional
       issuer: "TheScratch",
       ttl: { 30, :days },
       allowed_drift: 2000,
       verify_issuer: true, # optional
       secret_key: System.get_env("GUARDIAN_SECRET_KEY"),
       serializer: TheScratch.GuardianSerializer

config :the_scratch, TheScratch.Vfs,
       vfs: [
         %{
           :pattern => "web/graphql/**/*.graphql",
           :name => "graphql",
           :regex => ~r"web/graphql/(.*)\.graphql"
         }
       ]

config :ueberauth, Ueberauth,
       providers: [
         facebook: { Ueberauth.Strategy.Facebook, [profile_fields: "name,email,first_name,last_name"] },
         github: { Ueberauth.Strategy.Github, [] },
         google: { Ueberauth.Strategy.Google, [] },
         identity: { Ueberauth.Strategy.Identity, [
           callback_methods: ["POST"],
           uid_field: :username,
           nickname_field: :username,
         ] },
         twitter: { Ueberauth.Strategy.Twitter, []}
       ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
       client_id: System.get_env("FACEBOOK_APP_ID"),
       client_secret: System.get_env("FACEBOOK_APP_SECRET"),
       redirect_uri: System.get_env("FACEBOOK_REDIRECT_URI")

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
       client_id: System.get_env("GITHUB_CLIENT_ID"),
       client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
       client_id: System.get_env("GOOGLE_CLIENT_ID"),
       client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
       redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")


config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
       consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
       consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
