defmodule Fmylife.Story do
  use Fmylife.Web, :model

  schema "stories" do
    field :body, :string
    belongs_to :user, Fmylife.Story
    belongs_to :category, Fmylife.Story
    has_many :comments, Fmylife.Story

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
