defmodule Server.Repo.Migrations.CreateSources do
  use Ecto.Migration

  def change do
    create table(:sources) do
      add :file_name, :string
      add :body, :text

      timestamps()
    end

  end
end
