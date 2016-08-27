defmodule Notox.NoteView do
  use Notox.Web, :view

  def render_markdown(markdown) do
    markdown
    |> Earmark.to_html
    |> HtmlSanitizeEx.html5
    |> raw
  end
end
