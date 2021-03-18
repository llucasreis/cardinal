defmodule Cardinal.Repo.Migrations.CreateUserAnimeTable do
  use Ecto.Migration

  def change do
    create table(:user_animes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :current_episode, :integer
      add :user_score, :float
      add :watch_status, :string
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false
      add :anime_id, references(:animes, type: :uuid, on_delete: :delete_all), null: false
      timestamps()
    end

    create unique_index(:user_animes, [:user_id, :anime_id])
  end
end
