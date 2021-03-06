defmodule CardinalWeb.FallbackController do
  use CardinalWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(CardinalWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
