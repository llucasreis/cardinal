defmodule Cardinal.Anime do
  alias Cardinal.Anime

  defdelegate search_anime(params), to: Anime.Search, as: :execute
end
