import Config

config :seven, api_key: System.get_env("SEVEN_API_KEY")
config :seven, sent_with: "elixir"

import_config "#{config_env()}.exs"
