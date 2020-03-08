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
end
