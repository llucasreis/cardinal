defmodule Cardinal.User.Anime.Add do
  alias Cardinal.Kitsu.Client
  alias Cardinal.Kitsu.Info.Anime

  def execute(%{"kitsu_id" => kitsu_id}) do
    kitsu_id
    |> Client.get_anime_by_id()
    |> handle_data(kitsu_id)
  end

  defp handle_data({:ok, %{"data" => data}}, kitsu_id) do
    kitsu_id
    |> Client.get_genre_by_anime()
    |> handle_response(data)
  end

  defp handle_data({:error, _reason} = error, _kitsu_id), do: error

  defp handle_response({:ok, %{"data" => genres}}, anime) do
    {:ok, Anime.build(anime, genres)}
  end

  defp handle_response({:error, _reason} = error, _anime), do: error
end
