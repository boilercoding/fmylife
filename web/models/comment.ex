defmodule Fmylife.Comment do
  use Fmylife.Web, :model

  schema "comments" do
    field :body, :string
    belongs_to :story, Fmylife.Story
    belongs_to :user, Fmylife.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end

  def count(story_id) do
    hd Fmylife.Repo.all(
      from c in Fmylife.Comment,
      select: count(c.id),
      where: [story_id: ^story_id]
    )
  end
end
