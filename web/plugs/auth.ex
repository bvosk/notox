defmodule Notox.Auth do
  import Plug.Conn

  defp get_current_user(conn) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      current_user = Notox.Repo.get(Notox.User, current_user_id)

      if current_user do
        {:ok, current_user}
      else
        {:error, :user_not_found}
      end
    else
      {:error, :no_current_user}
    end
  end


  def init(opts), do: opts

  def call(conn, _opts) do
    case get_current_user(conn) do
      {:ok, current_user} ->
        assign(conn, :current_user, current_user)
      {:error, _description} ->
        assign(conn, :current_user, nil)
    end
  end
end
