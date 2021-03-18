defmodule CardinalWeb.UserAnimesController do
  use CardinalWeb, :controller

  alias Cardinal.User
  alias Cardinal.Schemas.UserAnime

  action_fallback CardinalWeb.FallbackController

  def add_anime(conn, params) do
    with {:ok, %UserAnime{} = user_anime} <- User.add_anime(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user_anime: user_anime)
    end
  end
end
