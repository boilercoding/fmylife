defmodule Fmylife.Story do
  use Fmylife.Web, :model
  alias Fmylife.{Repo, Story}

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
    Repo.all(
      from s in Story,
      left_join: l in assoc(s, :likes),
      where: l.dislike == false,
      order_by: [desc: count(l.id), desc: s.inserted_at],
      group_by: s.id,
      select: s,
      limit: 10,
      preload: [:user, :comments]
    )
  end

  def random do
    Repo.all(
      from s in Story,
      order_by: [desc: fragment("Random()")],
      limit: 10,
      preload: [:user, :comments]
    )
  end

  def stories_of_category(category_id, params) do
    Story
    |> order_by(desc: :id)
    |> where(category_id: ^category_id)
    |> preload([:user, :comments])
    |> Repo.paginate(params)
  end

  def search(search_params, params) do
    from(s in Story,
    where: ilike(s.body, ^"%#{search_params}%"),
    preload: [:user, :comments])
    |> Repo.paginate(params)
  end

end
