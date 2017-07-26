defmodule TheScratch.User do
  @moduledoc """
  User Schema
  """

  use Ecto.Schema

  schema "users" do
    field :email, :string
    field :provider, :string
    field :profile, :map
    timestamps()
  end
end
