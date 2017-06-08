# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fmylife.Repo.insert!(%Fmylife.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Fmylife.Repo.delete_all Fmylife.Category

Fmylife.Category.changeset(%Fmylife.Category{}, %{name: "Money"})
|> Fmylife.Repo.insert!

Fmylife.Category.changeset(%Fmylife.Category{}, %{name: "Kids"})
|> Fmylife.Repo.insert!

Fmylife.Category.changeset(%Fmylife.Category{}, %{name: "Health"})
|> Fmylife.Repo.insert!

Fmylife.Category.changeset(%Fmylife.Category{}, %{name: "Intimacy"})
|> Fmylife.Repo.insert!

Fmylife.Category.changeset(%Fmylife.Category{}, %{name: "Work"})
|> Fmylife.Repo.insert!

Fmylife.Category.changeset(%Fmylife.Category{}, %{name: "Transportation"})
|> Fmylife.Repo.insert!

Fmylife.Repo.delete_all Fmylife.User

Fmylife.User.changeset(%Fmylife.User{}, %{name: "Test User", email: "testuser@example.com", password: "secret", password_confirmation: "secret"})
|> Fmylife.Repo.insert!
