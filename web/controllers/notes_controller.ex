defmodule Notox.NoteController do
  use Notox.Web, :controller

  def index(conn, _params) do
    notes = Repo.all(Notox.Note)
    render conn, "index.html", notes: notes
  end
end
