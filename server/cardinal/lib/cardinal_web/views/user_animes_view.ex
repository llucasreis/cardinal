defmodule CardinalWeb.UserAnimesView do
  alias Cardinal.Schemas.UserAnime

  def render("create.json", %{
        user_anime: %UserAnime{
          id: id,
          current_episode: current_episode,
          watch_status: watch_status,
          anime_id: anime_id,
          user_id: user_id,
          user_score: user_score
        }
      }) do
    %{
      id: id,
      current_episode: current_episode,
      watch_status: watch_status,
      user_score: user_score,
      anime_id: anime_id,
      user_id: user_id
    }
  end
end
