defmodule Fmylife.LikeTest do
  use Fmylife.ModelCase

  alias Fmylife.Like

  @valid_attrs %{dislike: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Like.changeset(%Like{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Like.changeset(%Like{}, @invalid_attrs)
    refute changeset.valid?
  end
end
