defmodule Notox.PageController do
  use Notox.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
