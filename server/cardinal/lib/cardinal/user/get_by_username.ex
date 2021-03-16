defmodule Cardinal.User.GetByUsername do
  import Ecto.Query
  alias Cardinal.Repo
  alias Cardinal.Schemas.User

  def execute(username) do
    case Repo.one(from u in User, where: u.username == ^username) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
