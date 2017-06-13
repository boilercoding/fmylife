defmodule Fmylife.LikeController do
  use Fmylife.Web, :controller
  alias Fmylife.Like

  def like(conn, %{"story_id" => story_id}) do
    user = Coherence.current_user(conn)
    like= %Like{story_id: String.to_integer(story_id), user_id: user.id}
    get_like = Repo.get_by(Like, user_id: user.id, story_id: String.to_integer(story_id), dislike: false)
    get_dislike = Repo.get_by(Like, user_id: user.id, story_id: String.to_integer(story_id), dislike: true)

    case get_dislike do
      nil ->
        case get_like do
          nil ->
            Repo.insert(like)
            conn |> redirect(to: get_session(conn, :back_path))
          _ ->
            Repo.delete!(get_like)
            conn |> redirect(to: get_session(conn, :back_path))
        end
      _ ->
        get_dislike = Ecto.Changeset.change(get_dislike, dislike: false)
        Repo.update!(get_dislike)
        conn |> redirect(to: get_session(conn, :back_path))
    end
  end

  def dislike(conn, %{"story_id" => story_id}) do
    user = Coherence.current_user(conn)
    dislike= %Like{story_id: String.to_integer(story_id), user_id: user.id, dislike: true}
    get_dislike = Repo.get_by(Like, user_id: user.id, story_id: String.to_integer(story_id), dislike: true)
    get_like = Repo.get_by(Like, user_id: user.id, story_id: String.to_integer(story_id), dislike: false)

    case get_like do
      nil ->
        case get_dislike do
          nil ->
            Repo.insert(dislike)
            conn |> redirect(to: get_session(conn, :back_path))
          _ ->
            Repo.delete!(get_dislike)
            conn |> redirect(to: get_session(conn, :back_path))
        end
      _ ->
        get_like = Ecto.Changeset.change(get_like, dislike: true)
        Repo.update!(get_like)
        conn |> redirect(to: get_session(conn, :back_path))
    end
  end
end
