defmodule Wabanex.Repo.Migrations.ChangeExercisesTable do
  use Ecto.Migration

  def change do
    alter table(:exercises) do
      add :protocol_description, :string
      remove :protocol_desciption
    end
  end
end
