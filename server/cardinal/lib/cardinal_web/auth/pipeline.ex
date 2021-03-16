defmodule CardinalWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :cardinal

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
