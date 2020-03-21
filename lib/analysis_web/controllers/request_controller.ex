defmodule AnalysisWeb.RequestController do
  use AnalysisWeb, :controller

  alias Analysis.Accounts
  alias Analysis.Accounts.Request

  action_fallback AnalysisWeb.FallbackController

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    requests = Accounts.list_requests_for_current_user(current_user)
    render(conn, "index.json", requests: requests)
  end

  def create(conn, %{"request" => request_params}) do
    with {:ok, %Request{} = request} <- Accounts.create_request(request_params) do
      conn
      |> put_status(:created)
      |> render("show.json", request: request)
    end
  end

  def show(conn, %{"id" => id}) do
    request = Accounts.get_request!(id)
    render(conn, "show.json", request: request)
  end

  def update(conn, %{"id" => id, "request" => request_params}) do
    request = Accounts.get_request!(id)

    with {:ok, %Request{} = request} <- Accounts.update_request(request, request_params) do
      render(conn, "show.json", request: request)
    end
  end

  def delete(conn, %{"id" => id}) do
    request = Accounts.get_request!(id)

    with {:ok, %Request{}} <- Accounts.delete_request(request) do
      send_resp(conn, :no_content, "")
    end
  end
end
