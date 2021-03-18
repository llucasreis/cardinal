defmodule Cardinal.User.Anime.Add do
  import Ecto.Query
  alias Cardinal.Repo
  alias Cardinal.Schemas.Anime, as: AnimeSchema
  alias Cardinal.Kitsu.Client
  alias Cardinal.Kitsu.Info.Anime, as: AnimeStruct
  alias Cardinal.Schemas.UserAnime
  import Cardinal.Utils.MapUtil

  def execute(%{"kitsu_id" => kitsu_id} = params) do
    case fetch_anime(kitsu_id) do
      nil -> create_anime_and_add_user_anime(kitsu_id, params)
      anime -> add_user_anime(anime.id, params)
    end
  end

  defp fetch_anime(kitsu_id), do: Repo.one(from a in AnimeSchema, where: a.kitsu_id == ^kitsu_id)

  defp add_user_anime(anime_id, request_params) do
    anime_data = %{anime_id: anime_id}
    request_params = convert_map_string_to_atom(request_params)
    params = anime_data ||| request_params

    params
    |> UserAnime.changeset()
    |> Repo.insert()
  end

  # defp handle_user_anime_build({:ok, user_anime}), do: Repo.insert(user_anime)
  # defp handle_user_anime_build({:error, _changeset} = error), do: error

  defp create_anime_and_add_user_anime(kitsu_id, params) do
    kitsu_id
    |> Client.get_anime_by_id()
    |> handle_response(kitsu_id, params)
  end

  defp handle_response({:error, _reason} = error, _kitsu_id, _params), do: error

  defp handle_response({:ok, %{"data" => anime}}, kitsu_id, params) do
    kitsu_id
    |> Client.get_genre_by_anime()
    |> handle_genre_response(anime, params)
  end

  defp handle_genre_response({:error, _reason} = error, _anime, _params), do: error

  defp handle_genre_response({:ok, %{"data" => genres}}, anime, params) do
    AnimeStruct.build(anime, genres)
    |> create_anime(params)
  end

  defp create_anime(
         %AnimeStruct{
           kitsu_id: kitsu_id,
           title: title,
           slug: slug,
           description: description,
           episodes: episodes,
           genres: genres,
           image_url: image_url,
           status: status
         },
         params
       ) do
    %{
      kitsu_id: kitsu_id,
      title: title,
      slug: slug,
      description: description,
      episodes: episodes,
      genres: genres,
      image_url: image_url,
      status: status
    }
    |> AnimeSchema.build()
    |> handle_anime_build(params)
  end

  defp handle_anime_build({:error, _changeset} = error, _params), do: error

  defp handle_anime_build({:ok, anime}, params) do
    anime
    |> Repo.insert()
    |> handle_anime_insert(params)
  end

  defp handle_anime_insert({:error, _changeset} = error, _request_params), do: error

  defp handle_anime_insert({:ok, %{id: id}}, request_params) do
    add_user_anime(id, request_params)
  end
end
