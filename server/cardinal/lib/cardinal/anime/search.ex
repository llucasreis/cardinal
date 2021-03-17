defmodule Cardinal.Anime.Search do
  alias Cardinal.Kitsu.Client
  alias Cardinal.Kitsu.Search.Anime

  def execute(anime) do
    anime
    |> Client.search_anime()
    |> handle_response()
  end

  defp handle_response({:ok, %{"data" => data}}) do
    search_anime_result = Enum.map(data, fn item -> Anime.build(item) end)
    {:ok, search_anime_result}
  end

  defp handle_response({:error, _reason} = error), do: error
end
