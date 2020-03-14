defmodule Analysis.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :method, :string
      add :url, :string
      add :auth, :map
      add :params, :map
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:requests, [:user_id])
  end
end
