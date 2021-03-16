defmodule Cardinal.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    timestamps()
  end

  @required_params [:username, :email, :password]

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 5)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
