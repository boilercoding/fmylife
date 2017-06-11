defmodule Fmylife.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :dislike, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :story_id, references(:stories, on_delete: :nothing)

      timestamps()
    end
    create index(:likes, [:user_id])
    create index(:likes, [:story_id])

  end
end
