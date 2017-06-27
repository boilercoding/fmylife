defmodule Fmylife.StoryView do
  use Fmylife.Web, :view
  alias Fmylife.{Like, StoryView}
  import Kerosene.HTML

  def time_ago_in_words(time) do
    ts = NaiveDateTime.to_erl(time) |> :calendar.datetime_to_gregorian_seconds
    diff = :calendar.datetime_to_gregorian_seconds(:calendar.universal_time) - ts
    rel_from_now(:calendar.seconds_to_daystime(diff))
  end

  defp rel_from_now({0, {0, 0, sec}}) when sec < 30,
    do: "just now"
  defp rel_from_now({0, {0, min, _}}) when min < 2,
    do: "1 minute ago"
  defp rel_from_now({0, {0, min, _}}),
    do: "#{min} minutes ago"
  defp rel_from_now({0, {1, _, _}}),
    do: "1 hour ago"
  defp rel_from_now({0, {hour, _, _}}) when hour < 24,
    do: "#{hour} hours ago"
  defp rel_from_now({1, {_, _, _}}),
    do: "1 day ago"
  defp rel_from_now({day, {_, _, _}}) when day < 0,
    do: "just now"
  defp rel_from_now({day, {_, _, _}}),
    do: "#{day} days ago"

  def liked?(user, story) do
   case Like.liked?(user, story) do
     nil -> ""
     _ -> "active"
   end
  end

  def disliked?(user, story) do
    case Like.disliked?(user, story) do
      nil -> ""
      _ -> "active"
    end
  end

  def gravatar_for(email, size \\ 80) do
    gravatar_id = hash(email)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&default=mm"
  end
  defp md5(str) do
    :crypto.hash(:md5 , str) |> Base.encode16(case: :lower)
  end
  defp hash(email) do
    email
    |> String.strip
    |> String.downcase
    |> md5()
  end
end
