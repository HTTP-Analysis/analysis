defmodule Analysis.Accounts do
  import Ecto.Query, warn: false
  alias Analysis.Repo

  alias Analysis.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user(%{"email" => email}) do
    User
    |> where(email: ^email)
    |> Repo.one
    |> case do
      nil -> {:auth, %{email: "not found."}}
      user -> user
    end
  end

  def user_by_id(user_id) do
    User
    |> where(id: ^user_id)
    |> Repo.one
  end

  def verify_pass(%{"password" => password}, user) do
    case Bcrypt.verify_pass(password, user.password) do
      true -> :ok
      _ -> {:auth, %{password: "not correct."}}
    end
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Analysis.Accounts.Request

  def list_requests do
    Repo.all(Request)
  end

  def get_request!(id), do: Repo.get!(Request, id)

  def create_request(attrs \\ %{}) do
    %Request{}
    |> Request.changeset(attrs)
    |> Repo.insert()
  end

  def update_request(%Request{} = request, attrs) do
    request
    |> Request.changeset(attrs)
    |> Repo.update()
  end

  def delete_request(%Request{} = request) do
    Repo.delete(request)
  end

  def change_request(%Request{} = request) do
    Request.changeset(request, %{})
  end
end
