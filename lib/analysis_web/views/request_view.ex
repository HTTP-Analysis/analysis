defmodule AnalysisWeb.RequestView do
  use AnalysisWeb, :view
  alias AnalysisWeb.RequestView

  def render("index.json", %{requests: requests}) do
    %{data: render_many(requests, RequestView, "request.json")}
  end

  def render("show.json", %{request: request}) do
    %{data: render_one(request, RequestView, "request.json")}
  end

  def render("request.json", %{request: request}) do
    %{id: request.id,
      method: request.method,
      url: request.url,
      auth: request.auth,
      params: request.params}
  end
end
