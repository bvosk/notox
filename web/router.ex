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

  pipeline :require_user do
    plug Notox.RequireUser
  end

  scope "/", Notox do
    pipe_through [:browser]

    resources "/users", UserController,
      only: [:new, :create, :show]
    resources "/account", AccountController,
      only: [:show, :edit, :update, :delete],
      singleton: true
    resources "/signout", SessionController,
      as: :sign_out,
      only: [:delete],
      singleton: true
    resources "/notes", NoteController
  end

  scope "/", Notox do
    pipe_through [:browser] 

    get "/", PageController, :index 
    resources "/signin", SessionController,
      as: :sign_in,
      only: [:new, :create],
      singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", Notox do
  #   pipe_through :api
  # end
end
