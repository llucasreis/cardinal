defmodule Cardinal.User.GetById do
  alias Ecto.UUID
  alias Cardinal.Repo
  alias Cardinal.Schemas.User

  def execute(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get_by_id(uuid)
    end
  end

  defp get_by_id(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found!"}
      user -> {:ok, user}
    end
  end
end
