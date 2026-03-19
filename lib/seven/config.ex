defmodule Seven.Config do
  @moduledoc """
  Seven Config Module
  """

  @doc """
  Return configured API Key

  ### Examples

      iex> Application.put_env(:seven_io, :api_key, "your apikey")
      iex> Seven.Config.api_key!()
      "your apikey"

  """
  @spec api_key!() :: String.t() | no_return
  def api_key!, do: Application.fetch_env!(:seven_io, :api_key)

  @doc """
  Return configured origin parameter

  ### Examples

      iex> Application.put_env(:seven_io, :sent_with, "elixir")
      iex> Seven.Config.sent_with!()
      "elixir"

  """
  @spec sent_with!() :: String.t() | no_return
  def sent_with!, do: Application.fetch_env!(:seven_io, :sent_with)
end
