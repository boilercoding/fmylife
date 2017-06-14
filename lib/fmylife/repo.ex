defmodule Fmylife.Repo do
  use Ecto.Repo, otp_app: :fmylife
  use Kerosene, per_page: 10
end
