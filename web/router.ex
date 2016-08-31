defmodule Notox.Router do
  use Notox.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Notox.Auth, repo: Notox.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Notox do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController,
      only: [:new, :create, :show]
    resources "/account", AccountController,
      only: [:show, :edit, :update, :delete],
      singleton: true
    resources "/session", SessionController,
      only: [:new, :create, :delete],
      singleton: true
    resources "/notes", NoteController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Notox do
  #   pipe_through :api
  # end
end
