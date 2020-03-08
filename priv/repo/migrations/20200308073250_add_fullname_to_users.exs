defmodule Analysis.Repo.Migrations.AddFullnameToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :fullname, :text
    end
  end
end
