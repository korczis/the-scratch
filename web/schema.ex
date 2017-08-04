defmodule TheScratch.Schema do
  @moduledoc """
  GraphQL Schema
  """

  alias TheScratch.UserResolver

  use Absinthe.Schema
  import_types TheScratch.Schema.Types

  query do
    field :users, list_of(:user) do
      resolve &TUserResolver.all/2
    end
  end

end
