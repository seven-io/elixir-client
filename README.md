![Sms77.io Logo](https://www.sms77.io/wp-content/uploads/2019/07/sms77-Logo-400x79.png "Sms77.io Logo")

# Official Elixir API Client for the Sms77.io SMS Gateway

## Installation

Add the package to your `mix.exs` dependencies:

```elixir
def deps do
  [{:sms77, "~> 0.1"}]
end
```

Fetch dependencies and start elixir console:

```console
mix deps.get
iex -S mix
```

### Example

```elixir
# If your API key is not set as environment variable SMS77_API_KEY
# Application.put_env(:sms77, :api_key, "INSERT_YOUR_SMS77_API_KEY")

Sms77.Balance.get!
```

#### Support

Need help? Feel free to [contact us](https://www.sms77.io/en/company/contact/).

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](./LICENSE)