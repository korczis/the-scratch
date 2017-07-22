defmodule WebSpa.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :profile, :map
      timestamps()
    end
  end
end
