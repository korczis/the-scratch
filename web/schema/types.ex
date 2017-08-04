defmodule TheScratch.Schema.Types do
  @moduledoc """
  GraphQL Schema Types
  """

  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :email, :string
  end
end
