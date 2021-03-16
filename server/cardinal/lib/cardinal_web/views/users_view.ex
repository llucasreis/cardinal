defmodule CardinalWeb.UsersView do
  alias Cardinal.Schemas.User

  def render("create.json", %{
        user: %User{id: id, username: username, email: email},
        token: token
      }) do
    %{
      message: "User created",
      user: %{
        id: id,
        username: username,
        email: email
      },
      token: token
    }
  end

  def render("show.json", %{
        user: %User{id: id, username: username, email: email}
      }) do
    %{
      id: id,
      username: username,
      email: email
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{token: token}
  end
end
