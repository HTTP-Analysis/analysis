defmodule AnalysisWeb.AuthenticationPlug do
  import Plug.Conn
  alias Analysis.Accounts
  alias Analysis.Accounts.User

  def init(_opts) do
  end

  def call(conn, _) do
    conn
    |> Plug.Conn.get_req_header("authorization")
    |> List.first
    |> to_string
    |> String.replace_leading("Bearer ", "")
    |> handle_response(conn)
  end

  defp handle_response(%User{} = user, email, conn), do: handle_response(user.email == email, conn, user)
  defp handle_response(true, conn, user), do: conn |> assign(:current_user, user)
  defp handle_response(false, conn, _user), do: unauth(conn)
  defp handle_response(nil, conn), do: unauth(conn) 
  defp handle_response({:ok, %{"email" => email, "id" => user_id}}, conn), do: Accounts.user_by_id(user_id) |> handle_response(email, conn)
  defp handle_response({:error, _}, conn), do: unauth(conn)
  defp handle_response(token, conn), do: AnalysisWeb.JwtAuthToken.verify_and_validate(token) |> handle_response(conn)

  defp unauth(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> resp(401, Jason.encode!(%{message: "Invalid API keys or JWT token"}))
    |> send_resp
    |> halt
  end
end
