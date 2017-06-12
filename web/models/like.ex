defmodule Fmylife.Like do
  use Fmylife.Web, :model

  schema "likes" do
    field :dislike, :boolean, default: false
    belongs_to :user, Fmylife.User
    belongs_to :story, Fmylife.Story

    timestamps()
  end

  def total_likes(user_id, story_id) do
    total(user_id, story_id, false)
  end

  def total_dislikes(user_id, story_id) do
    total(user_id, story_id, true)
  end

  def liked?(user_id, story_id) do
    find_like(user_id, story_id, false)
  end

  def disliked?(user_id, story_id) do
    find_like(user_id, story_id, true)
  end

  defp find_like(user_id, story_id, dislike) do
    Fmylife.Repo.get_by(
      Fmylife.Like,
      user_id: user_id,
      story_id: story_id,
      dislike: dislike
    )
  end


  defp total(user_id, story_id, dislike) do
    hd Fmylife.Repo.all(
      from l in Fmylife.Like,
      select: count(l.id),
      where: [user_id: ^user_id, story_id: ^story_id, dislike: ^dislike]
    )
  end

end
