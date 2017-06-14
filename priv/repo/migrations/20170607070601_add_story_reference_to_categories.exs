defmodule Fmylife.Repo.Migrations.AddStoryReferenceToCategories do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :category_id, references(:categories, on_delete: :delete_all)
    end
    create index(:stories, [:category_id])
  end
end
