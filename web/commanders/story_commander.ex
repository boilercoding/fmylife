defmodule Fmylife.StoryCommander do
  use Drab.Commander
  alias Fmylife.{Like, Repo}

  access_session :user_id

  def like(socket, dom_sender) do
    user = get_session(socket, :user_id)
    story_id = socket |> select(data: "storyId", from: this(dom_sender))
    liked? = Like.liked?(user, story_id)
    case liked? do
      nil -> like_or_unlike(socket, dom_sender, false, false)
      _ -> like_or_unlike(socket, dom_sender, true, true)
    end
  end

  def dislike(socket, dom_sender) do
    user = get_session(socket, :user_id)
    story_id = socket |> select(data: "storyId", from: this(dom_sender))
    liked? = Like.disliked?(user, story_id)
    case liked? do
      nil -> dislike_or_undislike(socket, dom_sender, false, false)
      _ -> dislike_or_undislike(socket, dom_sender, true, true)
    end
  end

  defp like_or_unlike(socket, dom_sender, html?, unlike) do
    user = get_session(socket, :user_id)
    story_id = socket |> select(data: "storyId", from: this(dom_sender))
    like= %Like{story_id: story_id, user_id: user}
    get_like = Repo.get_by(Like, user_id: user, story_id: story_id, dislike: false)
    get_dislike = Repo.get_by(Like, user_id: user, story_id: story_id, dislike: true)
    html_unlike = "<button data-story-id='#{story_id}'class='btn btn-info btn-xs' drab-click='like'>Your life sucks</button>"
    html_like = "<button data-story-id='#{story_id}'class='btn btn-info btn-xs active' drab-click='like'>Your life sucks</button>"
    html_undislike = "<button data-story-id='#{story_id}'class='btn btn-primary btn-xs' drab-click='dislike'>You deserved it</button>"

    html = if html?, do: html_unlike, else: html_like

    case get_dislike do
      nil ->
        if unlike, do: Repo.delete!(get_like), else: Repo.insert(like)
      _ ->
        get_dislike = Ecto.Changeset.change(get_dislike, dislike: false)
        Repo.update!(get_dislike)
    end

    total_likes = Like.total_likes(story_id)
    total_dislikes = Like.total_dislikes(story_id)

    socket
    |> delete(from: "#like-button-#{story_id}")
    |> insert(html, append: "#like-button-#{story_id}")
    |> delete!(from: "#total-likes-#{story_id}")
    |> insert!("(#{total_likes})", append: "#total-likes-#{story_id}")
    |> delete(from: "#dislike-button-#{story_id}")
    |> insert(html_undislike, append: "#dislike-button-#{story_id}")
    |> delete!(from: "#total-dislikes-#{story_id}")
    |> insert!("(#{total_dislikes})", append: "#total-dislikes-#{story_id}")
  end

  defp dislike_or_undislike(socket, dom_sender, html?, undislike) do
    user = get_session(socket, :user_id)
    story_id = socket |> select(data: "storyId", from: this(dom_sender))
    dislike= %Like{story_id: story_id, user_id: user, dislike: true}
    get_like = Repo.get_by(Like, user_id: user, story_id: story_id, dislike: false)
    get_dislike = Repo.get_by(Like, user_id: user, story_id: story_id, dislike: true)
    html_undislike = "<button data-story-id='#{story_id}'class='btn btn-primary btn-xs' drab-click='dislike'>You deserved it</button>"
    html_dislike = "<button data-story-id='#{story_id}'class='btn btn-primary btn-xs active' drab-click='dislike'>You deserved it</button>"
    html_unlike = "<button data-story-id='#{story_id}'class='btn btn-info btn-xs' drab-click='like'>Your life sucks</button>"
    html = if html?, do: html_undislike, else: html_dislike

    case get_like do
      nil ->
        if undislike, do: Repo.delete!(get_dislike), else: Repo.insert(dislike)
      _ ->
        get_like = Ecto.Changeset.change(get_like, dislike: true)
        Repo.update!(get_like)
    end

    total_likes = Like.total_likes(story_id)
    total_dislikes = Like.total_dislikes(story_id)

    socket
    |> delete(from: "#dislike-button-#{story_id}")
    |> insert(html, append: "#dislike-button-#{story_id}")
    |> delete!(from: "#total-dislikes-#{story_id}")
    |> insert!("(#{total_dislikes})", append: "#total-dislikes-#{story_id}")
    |> delete(from: "#like-button-#{story_id}")
    |> insert(html_unlike, append: "#like-button-#{story_id}")
    |> delete!(from: "#total-likes-#{story_id}")
    |> insert!("(#{total_likes})", append: "#total-likes-#{story_id}")
  end

end
