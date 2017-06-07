defmodule Fmylife.PageController do
  use Fmylife.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
