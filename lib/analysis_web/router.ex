defmodule AnalysisWeb.Router do
  use AnalysisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AnalysisWeb do
    pipe_through :api
  end
end
