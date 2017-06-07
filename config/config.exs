# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fmylife,
  ecto_repos: [Fmylife.Repo]

# Configures the endpoint
config :fmylife, Fmylife.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DabXP5seYtA4ZzeeFWT+jxdGyXIVWiRxBXk66/5I2kusP3C7CtuhkfLu8uRnhHkZ",
  render_errors: [view: Fmylife.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fmylife.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Fmylife.User,
  repo: Fmylife.Repo,
  module: Fmylife,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:rememberable, :authenticatable, :recoverable, :unlockable_with_token, :registerable]

config :coherence, Fmylife.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
