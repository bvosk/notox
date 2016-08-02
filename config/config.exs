# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :notox,
  ecto_repos: [Notox.Repo]

# Configures the endpoint
config :notox, Notox.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KY7s0H5pbFzAIsJMZGpmfggHUMjZsXaCN9I9FKZ6McoQV5zSKh86qTyW4wDgn6Z/",
  render_errors: [view: Notox.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Notox.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
