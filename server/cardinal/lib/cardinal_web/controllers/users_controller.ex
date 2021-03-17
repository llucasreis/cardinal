defmodule CardinalWeb.UsersController do
  use CardinalWeb, :controller

  alias Cardinal.User
  alias Cardinal.Schemas.User, as: UserSchema
  alias CardinalWeb.Auth.Guardian

  action_fallback CardinalWeb.FallbackController

  def create(conn, params) do
    with {:ok, %UserSchema{} = user} <- User.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def get_by_id(conn, %{"id" => id}) do
    with {:ok, %UserSchema{} = user} <- User.get_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def get_by_username(conn, %{"username" => username}) do
    with {:ok, %UserSchema{} = user} <- User.get_by_username(username) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _deleted} <- User.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, %UserSchema{} = user} <- User.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def add_anime(conn, params) do
    with {:ok, anime} <- User.add_anime(params) do
      conn
      |> put_status(:ok)
      |> json(anime)
    end
  end
end
