# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lotto_api,
  namespace: LottoAPI,
  ecto_repos: [LottoAPI.Repo]

# Configures the endpoint
config :lotto_api, LottoAPIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7DiR14BsTWx8R1xRT/S2cC74q3UOClG5h4gzn4TZTQ8nO5RBdIu0foC4Hvo2Xt2N",
  render_errors: [view: LottoAPIWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LottoAPI.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :lotto_api, LottoAPI.Guardian,
  issuer: "lotto_api",
  secret_key: "2AUmYUxHsb+E6m+853Ynoa+bEt69R1UIdutOAcmAo/o4bCaRL85giC1M7azGeDyL"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
