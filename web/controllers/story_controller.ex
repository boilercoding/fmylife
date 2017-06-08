defmodule Fmylife.StoryController do
  use Fmylife.Web, :controller

  alias Fmylife.User
  alias Fmylife.Story
  alias Fmylife.Comment
  alias Fmylife.Category

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, _params) do
    changeset = Story.changeset(%Story{})
    render(conn, "new.html", changeset: changeset)
  end

end
