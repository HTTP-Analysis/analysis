defmodule Analysis.Repo.Migrations.AddHeadersToRequests do
  use Ecto.Migration

  def change do
    alter table("requests") do
      add :headers, :map
    end
  end
end
