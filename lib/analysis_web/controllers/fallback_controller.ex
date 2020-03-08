defmodule AnalysisWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use AnalysisWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(AnalysisWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(AnalysisWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:auth, message}) do
    conn
    |> put_status(400)
    |> put_view(AnalysisWeb.ErrorView)
    |> render("error.json", %{errors: message})
  end
end
