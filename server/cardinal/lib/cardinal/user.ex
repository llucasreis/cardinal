defmodule Cardinal.User do
  alias Cardinal.User

  defdelegate create_user(params), to: User.Create, as: :execute
  defdelegate get_by_id(params), to: User.GetById, as: :execute
  defdelegate delete_user(params), to: User.Delete, as: :execute
  defdelegate update_user(params), to: User.Update, as: :execute
  defdelegate get_by_username(params), to: User.GetByUsername, as: :execute

  defdelegate add_anime(params), to: User.Anime.Add, as: :execute
end
