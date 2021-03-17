defmodule Cardinal.Kitsu.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://kitsu.io/api/edge"
  plug Tesla.Middleware.DecodeJson, decode_content_types: ["application/vnd.api+json"]
  plug Tesla.Middleware.Headers, [{"Accept", "application/json, application/vnd.api+json"}]

  def get_genre_by_anime(kitsu_id) do
    "/anime/#{kitsu_id}/genres"
    |> get()
    |> handle_get_genres()
  end

  def search_anime(anime) do
    anime
    |> prepare_uri()
    |> get()
    |> handle_search()
  end

  def get_anime_by_id(kitsu_id) do
    "/anime/#{kitsu_id}"
    |> get()
    |> handle_get_anime()
  end

  defp prepare_uri(anime) do
    anime = String.downcase(anime)

    "/anime?filter%5Btext%5D=#{anime}"
  end

  defp handle_search({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_search({:ok, %Tesla.Env{status: 404}}), do: {:error, "Anime not found"}
  defp handle_search({:error, _reason} = error), do: error

  defp handle_get_genres({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_get_genres({:ok, %Tesla.Env{status: 404}}), do: {:error, "Genres not found"}
  defp handle_get_genres({:error, _reason} = error), do: error

  defp handle_get_anime({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_get_anime({:ok, %Tesla.Env{status: 404}}), do: {:error, "Anime not found"}
  defp handle_get_anime({:error, _reason} = error), do: error
end
