defmodule Analysis.Repo.Migrations.AddTitleToRequests do
  use Ecto.Migration

  def change do
    alter table("requests") do
      add :title, :string
    end
  end
end
