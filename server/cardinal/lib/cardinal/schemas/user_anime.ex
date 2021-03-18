defmodule Cardinal.Schemas.UserAnime do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cardinal.Schemas.{Anime, User}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  @watch_status_enum %{
    plan_to_watch: "PLAN_TO_WATCH",
    watching: "WATCHING",
    on_hold: "ON_HOLD",
    dropped: "DROPPED",
    completed: "COMPLETED"
  }

  schema "user_animes" do
    field :current_episode, :integer
    field :user_score, :float
    field :watch_status, :string
    belongs_to(:user, User)
    belongs_to(:anime, Anime)
    timestamps()
  end

  @cast_params [:current_episode, :user_score, :watch_status, :user_id, :anime_id]
  @required_params [:watch_status, :user_id, :anime_id]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @cast_params)
    |> validate_required(@required_params)
    |> validate_watch_status()
    |> unique_constraint([:user_id, :anime_id])
  end

  defp validate_watch_status(changeset) do
    watch_status = get_field(changeset, :watch_status)

    Map.values(@watch_status_enum)
    |> Enum.member?(watch_status)
    |> validate_watch_status(changeset, watch_status)
  end

  defp validate_watch_status(result, changeset, watch_status) when result == false do
    add_error(changeset, :enum_field, "#{watch_status} is not a valid option")
  end

  defp validate_watch_status(_result, changeset, _watch_status), do: changeset
end
