defmodule Analysis.Repo do
  use Ecto.Repo,
    otp_app: :analysis,
    adapter: Ecto.Adapters.Postgres
end
