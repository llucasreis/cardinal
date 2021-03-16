defmodule Cardinal.User.Create do
  alias Cardinal.Repo
  alias Cardinal.Schemas.User

  def execute(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
