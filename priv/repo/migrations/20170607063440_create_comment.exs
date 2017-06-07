defmodule Fmylife.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :story_id, references(:stories, on_delete: :nothing)

      timestamps()
    end
    create index(:comments, [:story_id])

  end
end
