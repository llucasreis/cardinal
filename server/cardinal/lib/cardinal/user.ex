defmodule Cardinal.User do
  alias Cardinal.User

  defdelegate create_user(params), to: User.Create, as: :execute
  defdelegate get_by_id(params), to: User.GetById, as: :execute
end
