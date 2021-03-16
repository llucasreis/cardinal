defmodule CardinalWeb.UsersController do
  use CardinalWeb, :controller

  alias Cardinal.User
  alias Cardinal.Schemas.User, as: UserSchema

  action_fallback CardinalWeb.FallbackController

  def create(conn, params) do
    with {:ok, %UserSchema{} = user} <- User.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def get_by_id(conn, %{"id" => id}) do
    with {:ok, %UserSchema{} = user} <- User.get_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end
end
