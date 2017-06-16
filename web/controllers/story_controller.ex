defmodule Fmylife.StoryController do
  use Fmylife.Web, :controller
  use Drab.Controller

  alias Fmylife.{User, Story, Comment, Category}

  def index(conn, params) do
    current_user = Coherence.current_user(conn)
    if conn.assigns.current_user do
      conn = put_session(conn, :user_id, current_user.id)
    end
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
    render(conn, :new, changeset: changeset)
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
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    story = Repo.get!(Story, id)
    render(conn, :show, story: story)
  end

end
