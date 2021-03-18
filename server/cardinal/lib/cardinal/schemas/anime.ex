defmodule Cardinal.Schemas.Anime do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "animes" do
    field :kitsu_id, :string
    field :title, :string
    field :slug, :string
    field :description, :string
    field :episodes, :integer
    field :genres, {:array, :string}
    field :image_url, :string
    field :status, :string
    timestamps()
  end

  @required_params [
    :kitsu_id,
    :title,
    :slug,
    :description,
    :genres,
    :image_url,
    :status
  ]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint(:kitsu_id)
    |> unique_constraint(:slug)
  end
end
