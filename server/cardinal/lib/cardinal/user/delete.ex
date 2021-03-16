defmodule Cardinal.User.Delete do
  alias Ecto.{Multi, UUID}
  alias Cardinal.Repo
  alias Cardinal.Schemas.User

  def execute(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    Multi.new()
    |> Multi.run(:fetch_user, Repo.get(User, uuid))
    |> Multi.delete(:delete_user, fn repo, %{fetch_user: user} ->
      repo.delete(user)
    end)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{delete_user: user}} -> {:ok, user}
    end
  end
end
