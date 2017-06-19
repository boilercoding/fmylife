defmodule Fmylife.Router do
  use Fmylife.Web, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", Fmylife do
    pipe_through :protected

    resources "/stories", StoryController, except: [:index, :show]
  end

  scope "/", Fmylife do
    pipe_through :browser # Use the default browser stack

    get "/", StoryController, :index
    get "/top-stories", StoryController, :top_stories
    get "/random", StoryController, :random
    get "/categories/:id", StoryController, :categories
    get "/stories/search", StoryController, :search 
    resources "/stories", StoryController, only: [:show]
  end


  # Other scopes may use custom stacks.
  # scope "/api", Fmylife do
  #   pipe_through :api
  # end
end
