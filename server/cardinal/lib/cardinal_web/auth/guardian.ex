defmodule CardinalWeb.Auth.Guardian do
  use Guardian, otp_app: :cardinal
  alias Cardinal.Schemas.User

  def subject_for_token(user, _claims) do
    sub = to_string(user.username)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> Cardinal.User.get_by_username()
  end

  def authenticate(%{"username" => username, "password" => password}) do
    case Cardinal.User.get_by_username(username) do
      {:error, message} -> {:error, message}
      {:ok, user} -> validate_password(user, password)
    end
  end

  defp validate_password(%User{password_hash: hash} = user, password) do
    case Bcrypt.verify_pass(password, hash) do
      true -> create_token(user)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, token}
  end
end
