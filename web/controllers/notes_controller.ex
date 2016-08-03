defmodule Notox.NoteController do
  use Notox.Web, :controller
  alias Notox.Note

  def index(conn, _params) do
    notes = Repo.all(Notox.Note)
    render conn, :index, notes: notes
  end

  def new(conn, _params) do
    changeset = Note.changeset(%Note{})
    render conn, :new, changeset: changeset
  end

  def edit(conn, %{"id" => id}) do
    note = Repo.get!(Note, id)
    changeset = Note.changeset(note)
    render conn, :edit, note: note, changeset: changeset
  end
end
