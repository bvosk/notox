defmodule Notox.Note do
  use Notox.Web, :model

  @required_fields [
    :title,
    :description,
  ]

  @optional_fields @required_fields

  schema "notes" do
    field :title, :string
    field :description, :string

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @optional_fields)
    |> validate_required(@required_fields)
  end
end
