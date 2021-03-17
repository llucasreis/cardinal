defmodule Cardinal.Kitsu.Info.Anime do
  @keys [:kitsu_id, :title, :slug, :description, :episodes, :image_url, :status, :genres]

  @enforce_keys @keys

  @derive Jason.Encoder
  defstruct @keys

  def build(
        %{
          "id" => kitsu_id,
          "attributes" => %{
            "slug" => slug,
            "description" => description,
            "episodeCount" => episodes,
            "posterImage" => %{
              "small" => image_url
            },
            "status" => status
          }
        } = data,
        genres
      ) do
    title = extract_title(data)

    %__MODULE__{
      kitsu_id: kitsu_id,
      title: title,
      slug: slug,
      description: description,
      episodes: episodes,
      image_url: image_url,
      status: status,
      genres: parse_genres(genres)
    }
  end

  defp extract_title(%{"attributes" => %{"titles" => %{"en" => title}}}), do: title
  defp extract_title(%{"attributes" => %{"titles" => %{"en_us" => title}}}), do: title
  defp extract_title(%{"attributes" => %{"titles" => %{"en_jp" => title}}}), do: title

  defp parse_genres(genres), do: Enum.map(genres, fn item -> item["attributes"]["name"] end)
end
