defmodule AnalysisWeb.Router do
  use AnalysisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["*"]
  end

  pipeline :auth do
    plug AnalysisWeb.AuthenticationPlug
  end

  scope "/api", AnalysisWeb do
    pipe_through :api

    post "/users/register", UserController, :create
    options "/users/register", UserController, :nothing
    post "/users/login", UserController, :login
    options "/users/login", UserController, :nothing

    scope "/" do
      pipe_through :auth

      get "/requests", RequestController, :index
      options "/requests", RequestController, :nothing
      post "/requests", RequestController, :create
      options "/requests", RequestController, :nothing
    end
  end
end
