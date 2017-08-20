defmodule TheScratch do
  @moduledoc """
  Root TheScratch module
  """

  use Application

  alias TheScratch.Endpoint, as: Endpoint

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(TheScratch.Endpoint, []),
      supervisor(TheScratch.Repo, []),
      worker(TheScratch.Vfs, [Application.get_env(:the_scratch, TheScratch.Vfs)[:vfs]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TheScratch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
