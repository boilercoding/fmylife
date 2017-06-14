defmodule Fmylife.Repo.Migrations.AddStoryReferenceToUsers do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
    create index(:stories, [:user_id])
  end
end
