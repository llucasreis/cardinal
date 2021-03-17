defmodule Cardinal.Kitsu.Search.Anime do
  @keys [:kitsu_id, :title, :slug, :description, :image_url]

  @enforce_keys @keys

  @derive Jason.Encoder
  defstruct @keys

  def build(
        %{
          "id" => kitsu_id,
          "attributes" => %{
            "slug" => slug,
            "description" => description,
            "posterImage" => %{
              "small" => image_url
            }
          }
        } = data
      ) do
    title = extract_title(data)

    %__MODULE__{
      kitsu_id: kitsu_id,
      title: title,
      slug: slug,
      description: description,
      image_url: image_url
    }
  end

  defp extract_title(%{"attributes" => %{"titles" => %{"en" => title}}}), do: title
  defp extract_title(%{"attributes" => %{"titles" => %{"en_us" => title}}}), do: title
  defp extract_title(%{"attributes" => %{"titles" => %{"en_jp" => title}}}), do: title
end
