![](https://www.seven.io/wp-content/uploads/Logo.svg "seven Logo")

# Official Elixir API Client for [seven](https://www.seven.io/)

## Installation

Add the package to your `mix.exs` dependencies:

```elixir
def deps do
  [{:seven, "~> 0.1"}]
end
```

Fetch dependencies and start elixir console:

```console
mix deps.get
iex -S mix
```

### Examples

```elixir
# If your API key is not set as environment variable SEVEN_API_KEY
# Application.put_env(:seven, :api_key, "INSERT_YOUR_SEVEN_API_KEY")

# Retrieve balance associated with given API key
Seven.Balance.get!

# Retrieve balance associated with given API key
Seven.Sms.post!(
  %{
    text: "HI2U!",
    to: "+491799999999",
  }
)
```

#### Support

Need help? Feel free to [contact us](https://www.seven.io/en/company/contact/).

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](LICENSE)
