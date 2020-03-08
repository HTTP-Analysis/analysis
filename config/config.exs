# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :analysis,
  ecto_repos: [Analysis.Repo]

# Configures the endpoint
config :analysis, AnalysisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "W3aKbuIgWgcXxoUS7jZtSZmhHsqksFk/hQfex57phtWFB3D3KQs+b8t81ZKOXOpO",
  render_errors: [view: AnalysisWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Analysis.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "YDKU88zW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :joken,
  default_signer: "secret"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
