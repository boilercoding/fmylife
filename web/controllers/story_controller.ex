defmodule Fmylife.StoryController do
  use Fmylife.Web, :controller

  alias Fmylife.{User, Story, Comment, Category}

  def index(conn, _params) do
    categories = Repo.all(Category)
    users = User |> Repo.all() |> Repo.preload([:stories])
    render(conn, "index.html", users: users, categories: categories)
  end

  def new(conn, _params) do
    changeset = Story.changeset(%Story{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"story" => story_params}) do
    current_user = Coherence.current_user(conn)
    changeset = Story.changeset(%Story{user_id: current_user.id}, story_params)

    case Repo.insert(changeset) do
      {:ok, story} ->
        conn
        |> put_flash(:success, "Story created successfully.")
        |> redirect(to: story_path(conn, :show, story))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    story = Repo.get!(Story, id)
    render(conn, "show.html", story: story)
  end

end
