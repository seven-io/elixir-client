import Config

config :sms77, api_key: System.get_env("SMS77_API_KEY")
config :sms77, sent_with: "elixir"

import_config "#{config_env()}.exs"