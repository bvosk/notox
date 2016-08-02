defmodule Notox.Repo.Migrations.CreateNote do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string, null: false
      add :description, :string, null: false

      timestamps
    end
  end
end
