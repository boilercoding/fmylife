defmodule Fmylife.StoryController do
  use Fmylife.Web, :controller
  use Drab.Controller

  alias Fmylife.{User, Story, Comment, Category}

  plug :assign_user_id_to_session when not action in [:new, :show, :update]

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
    categories = Repo.all(Category)
    changeset = Story.changeset(%Story{})
    render(conn, :new, changeset: changeset, categories: categories)
  end

  def create(conn, %{"story" => story_params}) do
    category_id = String.to_integer(story_params["category_id"])
    current_user = Coherence.current_user(conn)
    changeset = Story.changeset(%Story{user_id: current_user.id, category_id: category_id}, story_params)

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
    changeset = Comment.changeset(%Comment{})
    story = Repo.preload(
      Repo.get!(Story, id),
      [:user, {:comments, :user}]
    )
    render(conn, :show, story: story, changeset: changeset)
  end

  def top_stories(conn, _params) do
    stories = Story.top()
    categories = Repo.all(Category)
    render(conn, :top_stories, stories: stories, categories: categories)
  end

  def random(conn, _params) do
    stories = Story.random()
    categories = Repo.all(Category)
    render(conn, :random, stories: stories, categories: categories)
  end

  def categories(conn, params) do
    category_id = String.to_integer(params["id"])
    categories = Repo.all(Category)
    {stories, kerosene} = Story.stories_of_category(category_id, params)

    render(conn, :categories, stories: stories, categories: categories, kerosene: kerosene)
  end

  defp assign_user_id_to_session(conn, _) do
    current_user = Coherence.current_user(conn)
    if conn.assigns.current_user do
      conn = put_session(conn, :user_id, current_user.id)
    end
    conn
  end

end
