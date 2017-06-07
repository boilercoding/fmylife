defmodule Fmylife.Category do
  use Fmylife.Web, :model

  schema "categories" do
    field :name, :string
    has_many :stories, Fmylife.Story

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
