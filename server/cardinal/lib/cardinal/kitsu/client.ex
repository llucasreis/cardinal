defmodule Cardinal.Kitsu.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://kitsu.io/api/edge"
  plug Tesla.Middleware.DecodeJson, decode_content_types: ["application/vnd.api+json"]
  plug Tesla.Middleware.Headers, [{"Accept", "application/json, application/vnd.api+json"}]

  def get_anime(anime) do
    anime = String.downcase(anime)

    "/anime?filter%5Btext%5D=#{anime}"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}),
    do: {:ok, body}

  defp handle_get({:ok, %Tesla.Env{status: 404}}), do: {:error, "Anime not found"}
  defp handle_get({:error, _reason} = error), do: error
end
