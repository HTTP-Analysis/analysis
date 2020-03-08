defmodule AnalysisWeb.Router do
  use AnalysisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["*"]
  end

  scope "/api", AnalysisWeb do
    pipe_through :api

    post "/users/register", UserController, :create
    options "/users/register", UserController, :nothing
    post "/users/login", UserController, :login
    options "/users/login", UserController, :nothing
  end
end
