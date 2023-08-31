defmodule Seven.ValidateForVoice do
  @moduledoc "All code regarding endpoint /validate_for_voice belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "validate_for_voice"

  @spec post(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def post(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec post!(map()) :: map()
  def post!(params) do
    {:ok, response} = post(params)
    response
  end
end
