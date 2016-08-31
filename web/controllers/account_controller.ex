defmodule Notox.AccountController do
  use Notox.Web, :controller
  alias Notox.User

  def show(conn, _params) do
    user = Notox.Session.current_user(conn)
    render conn, Notox.UserView, :show, user: user
  end

  def edit(conn, _params) do
    user = Notox.Session.current_user(conn)
    changeset = User.changeset(user)

    render conn, :edit, user: user, changeset: changeset
  end

  def update(conn, %{"user" => user_params}) do
    user = Notox.Session.current_user(conn)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User updated.")
        |> redirect(to: account_path(conn, :show))
      {:error, changeset} ->
        render(conn, :edit, user: user, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    conn
    |> Notox.Session.current_user
    |> Repo.delete

    conn
    |> put_flash(:info, "User deleted.")
    |> redirect(to: page_path(conn, :index))
  end
end
