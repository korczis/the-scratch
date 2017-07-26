defmodule TheScratch.Schema do
  use Absinthe.Schema
  import_types TheScratch.Schema.Types

  query do
    field :users, list_of(:user) do
      resolve &TheScratch.UserResolver.all/2
    end
  end

end