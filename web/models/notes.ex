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

  def search(query, term) do
    like_term = "%" <> term <> "%"
    from n in query,
      where: ilike(n.title, ^like_term)
  end
end
