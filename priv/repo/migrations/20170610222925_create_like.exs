defmodule Fmylife.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :dislike, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all)
      add :story_id, references(:stories, on_delete: :delete_all)

      timestamps()
    end
    create index(:likes, [:user_id])
    create index(:likes, [:story_id])

  end
end
