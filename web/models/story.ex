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
end
