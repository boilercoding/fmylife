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
(1..10) |> Enum.each(fn n ->
  Fmylife.User.changeset(%Fmylife.User{}, %{
                        name: "Test User#{n}",
                        email: "testuser#{n}@example.com",
                        password: "secret",
                        password_confirmation: "secret"})
  |> Fmylife.Repo.insert!
end)

Fmylife.Repo.delete_all Fmylife.Story
(1..60) |> Enum.each(fn n ->
  Fmylife.Story.changeset(%Fmylife.Story{
    user_id: :rand.uniform(10),
    category_id: :rand.uniform(6)},
    %{body: "The quick brown fox jumps over the lazy dog. #{n}"})
  |> Fmylife.Repo.insert!
end)

Fmylife.Repo.delete_all Fmylife.Comment
(1..900) |> Enum.each(fn n ->
  Fmylife.Comment.changeset(%Fmylife.Comment{
    user_id: :rand.uniform(10),
    story_id: :rand.uniform(60)},
    %{body: "Locavore cardigan street art vice iPhone woke. #{n}"})
  |> Fmylife.Repo.insert!
end)
