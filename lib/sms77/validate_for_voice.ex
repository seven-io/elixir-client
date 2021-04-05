defmodule Sms77.ValidateForVoice do
  @moduledoc "All code regarding endpoint /validate_for_voice belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  def post(params) do
    case HTTPClient.post("validate_for_voice", {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  def post!(params) do
    {:ok, response} = post(params)
    response
  end
end