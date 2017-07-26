    defmodule TheScratch.Mixfile do
  use Mix.Project

  def project do
    [app: :the_scratch,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {TheScratch, []},
     applications: [
        :absinthe,
        :cowboy,
        :gettext,
        :guardian,
        :logger,
        :oauth,
        :phoenix,
        :phoenix_pubsub,
        :phoenix_html,
        :postgrex,
        :runtime_tools,
        :ueberauth_facebook,
        :ueberauth_google,
        :ueberauth_github,
        :ueberauth_identity,
        :ueberauth_linkedin,
        :ueberauth_twitter
     ]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
     {:absinthe, "~> 1.3"},
     {:absinthe_plug, "~> 1.3"},
     {:cors_plug, "~> 1.3"},
     {:cowboy, "~> 1.0"},
     {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
     {:ecto, "~> 2.1"},
     {:exfmt, github: "lpil/exfmt", only: [:dev, :test], runtime: false},
     {:gettext, "~> 0.11"},
     {:guardian, "~> 0.14"},
     {:oauth, github: "tim/erlang-oauth"},
     {:phoenix, "~> 1.2.4"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:postgrex, "~> 0.13.3"},
     {:ueberauth, "~> 0.4"},
     {:ueberauth_facebook, "~> 0.6"},
     {:ueberauth_github, "~> 0.4"},
     {:ueberauth_google, "~> 0.5"},
     {:ueberauth_identity, "~> 0.2"},
     {:ueberauth_linkedin , "~> 0.3 "},
     {:ueberauth_twitter, "~> 0.2"}
     ]
  end
end
