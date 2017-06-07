defmodule Fmylife.Repo.Migrations.CreateCoherenceUser do
  use Ecto.Migration
  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      # rememberable
      add :remember_created_at, :datetime
      # authenticatable
      add :password_hash, :string
      # recoverable
      add :reset_password_token, :string
      add :reset_password_sent_at, :datetime
      # unlockable_with_token
      add :unlock_token, :string
      
      timestamps()
    end
    create unique_index(:users, [:email])

  end
end
