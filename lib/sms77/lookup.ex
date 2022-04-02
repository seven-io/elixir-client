defmodule Sms77.Lookup do
  @moduledoc "All code regarding endpoint /lookup belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  @endpoint "lookup"

  @spec post(map()) :: {:ok, String.t() | map() | [map()]} | {:error, HTTPoison.Error | any()}
  def post(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec post!(map()) :: String.t() | map() | [map()]
  def post!(params) do
    {:ok, response} = post(params)
    response
  end
end