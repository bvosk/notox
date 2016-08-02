defmodule Notox.Note do
  use Notox.Web, :model

  schema "notes" do
    field :title, :string
    field :description, :string

    timestamps
  end
end
