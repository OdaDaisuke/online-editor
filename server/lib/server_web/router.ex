defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ServerWeb do
    pipe_through :api
    resources "/source", SourceController, except: [:edit, :new, :create, :update, :delete, :show]
    post "/source/exec", SourceController, :exec
  end
end
