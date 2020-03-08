defmodule AnalysisWeb.UserController do
  use AnalysisWeb, :controller

  alias AnalysisWeb.JwtAuthToken
  alias Analysis.Accounts
  alias Analysis.Accounts.User

  action_fallback AnalysisWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def login(conn, %{"user" => user_params}) do
    with %User{} = user <- Accounts.get_user(user_params),
         :ok <- Accounts.verify_pass(user_params, user)
    do
      exp =
        Calendar.DateTime.now_utc
        |> Calendar.DateTime.advance!(60 * 60 * 24 * 2)
        extra_claims = %{
          "fullname" => user.fullname,
          "email" => user.email,
          "exp" => exp |> DateTime.to_unix
        }
      {:ok, token, _} = JwtAuthToken.generate_and_sign(extra_claims)
      conn
      |> put_status(:created)
      |> render("token.json", token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
