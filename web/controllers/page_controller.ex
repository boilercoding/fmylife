defmodule Fmylife.PageController do
  use Fmylife.Web, :controller
  use Drab.Controller 

  def index(conn, _params) do
    render conn, "index.html"
  end
end
