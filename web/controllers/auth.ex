defmodule Notox.Session do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:current_user_id, user.id) 
    |> configure_session(renew: true)
  end

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def login_by_username_and_password(conn, username, given_password, options) do
    repo = Keyword.fetch!(options, :repo)
    user = repo.get_by(Notox.User, username: username)

    cond do
      user && checkpw(given_password, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
