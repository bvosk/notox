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

  def create(conn, %{"note" => note_params}) do
    changeset = Note.changeset(%Note{}, note_params)
    case Repo.insert(changeset) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created!")
        |> redirect(to: note_path(conn, :index))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
