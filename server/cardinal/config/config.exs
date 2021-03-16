# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cardinal,
  ecto_repos: [Cardinal.Repo]

# Configures the endpoint
config :cardinal, CardinalWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ddndNrtz0G2tDkq5ugvOMDZ0KI2k+L1H/9jOl3+EHa/IYVSIWgUVrnltyswU48sf",
  render_errors: [view: CardinalWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Cardinal.PubSub,
  live_view: [signing_salt: "VPsnTuEo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cardinal, CardinalWeb.Auth.Guardian,
  issuer: "cardinal",
  secret_key: System.get_env("SECRET_KEY")

config :cardinal, CardinalWeb.Auth.Pipeline,
  module: CardinalWeb.Auth.Guardian,
  error_handler: CardinalWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
