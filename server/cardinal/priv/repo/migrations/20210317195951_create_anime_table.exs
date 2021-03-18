defmodule Cardinal.Repo.Migrations.CreateAnimeTable do
  use Ecto.Migration

  def change do
    create table(:animes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :kitsu_id, :string
      add :title, :string
      add :slug, :string
      add :description, :text
      add :episodes, :integer
      add :genres, {:array, :string}
      add :image_url, :string
      add :status, :string
      timestamps()
    end

    create unique_index(:animes, [:kitsu_id])
    create unique_index(:animes, [:slug])
  end
end
