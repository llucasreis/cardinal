defmodule CardinalWeb.AnimesController do
  use CardinalWeb, :controller

  alias Cardinal.Anime

  action_fallback CardinalWeb.FallbackController

  def search_anime(conn, %{"anime" => anime}) do
    with {:ok, search_anime_result} <- Anime.search_anime(anime) do
      conn
      |> put_status(:ok)
      |> json(search_anime_result)
    end
  end
end
