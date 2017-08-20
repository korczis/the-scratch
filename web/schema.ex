defmodule TheScratch.Schema do
  @moduledoc """
  GraphQL Schema
  """

  alias TheScratch.UserResolver
  alias TheScratch.UsersResolver

  use Absinthe.Schema
  import_types TheScratch.Schema.Types

  query do
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &UserResolver.find/2
    end

    field :users, list_of(:user) do
      resolve &UsersResolver.all/2
    end
  end
end
