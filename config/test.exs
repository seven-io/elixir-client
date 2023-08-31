import Config

config :seven, api_key: System.get_env("SEVEN_API_KEY")

config :seven, sent_with: "elixir-test"

config :exvcr, [
  filter_request_headers: ["X-Api-Key"],
  response_headers_blacklist: ["X-sms77-trace-id"]
]
