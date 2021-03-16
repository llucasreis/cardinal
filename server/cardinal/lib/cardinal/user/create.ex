defmodule Cardinal.User.Create do
  alias Cardinal.Repo
  alias Cardinal.Schemas.User

  def execute(params) do
    params
    |> User.changeset()
    |> create_user()
  end

  defp create_user(changeset) do
    case Repo.insert(changeset) do
      {:error, changeset} -> {:error, changeset}
      {:ok, changeset} -> {:ok, changeset}
    end
  end
end
