<p align="center">
  <img src="https://www.seven.io/wp-content/uploads/Logo.svg" width="250" alt="seven logo" />
</p>

<h1 align="center">Official Elixir API Client</h1>

<p align="center">
  Send SMS, make voice calls, look up phone numbers, and more — via the <a href="https://www.seven.io">seven</a> API.
</p>

<p align="center">
  <a href="https://hex.pm/packages/seven_io"><img src="https://img.shields.io/hexpm/v/seven_io.svg?style=flat-square" alt="Hex Version" /></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-teal.svg?style=flat-square" alt="MIT License" /></a>
  <img src="https://img.shields.io/badge/Elixir-~%3E%201.14-blueviolet?style=flat-square" alt="Elixir ~> 1.14" />
</p>

---

## Prerequisites

- Elixir ~> 1.14
- A [seven account](https://www.seven.io) with API key ([How to get your API key](https://help.seven.io/en/api-key-access))

## Installation

Add the package to your `mix.exs` dependencies:

```elixir
def deps do
  [{:seven_io, "~> 0.1"}]
end
```

Then fetch dependencies:

```shell
mix deps.get
```

## Quick Start

```elixir
# Set your API key (or use the SEVEN_API_KEY environment variable)
Application.put_env(:seven_io, :api_key, "YOUR_API_KEY")

# Check your balance
Seven.Balance.get!()

# Send an SMS
Seven.Sms.post!(%{
  text: "Hello from seven!",
  to: "+491234567890"
})
```

## Usage Examples

### Send SMS

```elixir
Seven.Sms.post!(%{
  text: "Hello from seven!",
  to: "+491234567890"
})
```

### Text-to-Speech Voice Call

```elixir
Seven.Voice.post!(%{
  text: "Hello, this is a test call from seven.",
  to: "+491234567890"
})
```

### Phone Number Lookup

```elixir
Seven.Lookup.post!(%{
  number: "+491234567890",
  type: "mnp"
})
```

### Check Balance

```elixir
Seven.Balance.get!()
```

## All Features

| Feature | Module | Description |
|---------|--------|-------------|
| **SMS** | `Seven.Sms` | Send and manage SMS messages |
| **Voice** | `Seven.Voice` | Text-to-speech voice calls |
| **Lookup** | `Seven.Lookup` | Phone number lookups (HLR, CNAM, MNP, Format) |
| **Contacts** | `Seven.Contacts` | Manage address book contacts |
| **Hooks** | `Seven.Hooks` | Manage webhooks |
| **Balance** | `Seven.Balance` | Retrieve account balance |
| **Analytics** | `Seven.Analytics` | Retrieve account analytics |
| **Journal** | `Seven.Journal` | Retrieve message journal |
| **Pricing** | `Seven.Pricing` | Retrieve pricing information |
| **Status** | `Seven.Status` | Retrieve message delivery status |
| **ValidateForVoice** | `Seven.ValidateForVoice` | Validate phone numbers for voice calls |
| **Subaccounts** | `Seven.Subaccounts` | Manage subaccounts |

## API Pattern

All modules follow a consistent pattern with two variants:

```elixir
# Returns {:ok, result} or {:error, reason}
Seven.Sms.post(%{text: "Hi", to: "+49..."})

# Returns the result directly or raises on error
Seven.Sms.post!(%{text: "Hi", to: "+49..."})
```

## Support

Need help? Feel free to [contact us](https://www.seven.io/en/company/contact/) or [open an issue](https://github.com/seven-io/elixir-client/issues).

## License

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](LICENSE)
