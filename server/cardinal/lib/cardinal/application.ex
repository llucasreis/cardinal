defmodule Cardinal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    unless Mix.env() == :prod do
      Envy.auto_load()
      Envy.reload_config()
    end

    children = [
      # Start the Ecto repository
      Cardinal.Repo,
      # Start the Telemetry supervisor
      CardinalWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cardinal.PubSub},
      # Start the Endpoint (http/https)
      CardinalWeb.Endpoint
      # Start a worker by calling: Cardinal.Worker.start_link(arg)
      # {Cardinal.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cardinal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CardinalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
