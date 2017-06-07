defmodule Fmylife.StoryController do
  use Fmylife.Web, :controller

  alias Fmylife.User
  alias Fmylife.Story
  alias Fmylife.Comment
  alias Fmylife.Category

  def index(conn, _params) do
    render conn, "index.html"
  end

end
