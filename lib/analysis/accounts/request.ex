defmodule Analysis.Accounts.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field :auth, :map
    field :method, :string
    field :params, :map
    field :url, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:method, :url, :auth, :params])
    |> validate_required([:method, :url, :auth, :params])
  end
end
