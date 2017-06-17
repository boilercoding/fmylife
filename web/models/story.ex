defmodule Fmylife.Story do
  use Fmylife.Web, :model

  schema "stories" do
    field :body, :string
    belongs_to :user, Fmylife.User
    belongs_to :category, Fmylife.Category
    has_many :comments, Fmylife.Comment
    has_many :likes, Fmylife.Like

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

  def top do
    Fmylife.Repo.all(
      from s in Fmylife.Story,
      left_join: l in assoc(s, :likes),
      where: l.dislike == false,
      order_by: [desc: count(l.id), desc: s.inserted_at],
      group_by: s.id,
      select: s,
      limit: 10,
      preload: [:user]
    )
  end

  def random do
    Fmylife.Repo.all(
      from s in Fmylife.Story,
      order_by: [desc: fragment("Random()")],
      limit: 10,
      preload: [:user]
    )
  end
end
