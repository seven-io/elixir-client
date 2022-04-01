![](https://www.sms77.io/wp-content/uploads/2019/07/sms77-Logo-400x79.png "sms77 logo")

# Official Elixir API Client for the [sms77 SMS Gateway](https://www.sms77.io/)

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

### Examples

```elixir
# If your API key is not set as environment variable SMS77_API_KEY
# Application.put_env(:sms77, :api_key, "INSERT_YOUR_SMS77_API_KEY")

# Retrieve balance associated with given API key
Sms77.Balance.get!

# Retrieve balance associated with given API key
Sms77.Sms.post!(
  %{
    text: "HI2U!",
    to: "+491771783130",
  }
)
```

#### Support

Need help? Feel free to [contact us](https://www.sms77.io/en/company/contact/).

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](LICENSE)