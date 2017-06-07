defmodule Fmylife.Repo.Migrations.CreateStory do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :body, :text

      timestamps()
    end

  end
end
