defmodule Cardinal.Repo do
  use Ecto.Repo,
    otp_app: :cardinal,
    adapter: Ecto.Adapters.Postgres
end
