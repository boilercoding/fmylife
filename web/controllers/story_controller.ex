defmodule Fmylife.StoryController do
  use Fmylife.Web, :controller

  alias Fmylife.{User, Story, Comment, Category}

  def index(conn, params) do
    categories = Repo.all(Category)
    {stories, kerosene} =
    Story
    |> order_by(desc: :id)
    |> preload(:user)
    |> Repo.paginate(params)
    
    render(conn, :index,
      stories: stories,
      categories: categories,
      kerosene: kerosene)
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
