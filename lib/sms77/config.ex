defmodule Sms77.Config do
  @moduledoc """
  Sms77 Config Module
  """

  @doc """
  Return configured API Key

  ### Examples

      iex> Application.put_env(:sms77, :api_key, "your apikey")
      iex> Sms77.Config.api_key!()
      "your apikey"

  """
  @spec api_key!() :: String.t() | no_return
  def api_key!, do: Application.fetch_env!(:sms77, :api_key)

  @doc """
  Return configured origin parameter

  ### Examples

      iex> Application.put_env(:sms77, :sent_with, "elixir")
      iex> Sms77.Config.sent_with!()
      "elixir"

  """
  @spec sent_with!() :: String.t() | no_return
  def sent_with!, do: Application.fetch_env!(:sms77, :sent_with)
end