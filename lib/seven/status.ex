defmodule Seven.Status do
  @moduledoc "All code regarding endpoint /status belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "status"

  @spec get(integer()) :: {:ok, String.t()} | {:error, HTTPoison.Error | any()}
  def get(msg_id) do
    case HTTPClient.post(@endpoint, {:form, [msg_id: msg_id]}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec get!(integer()) :: String.t()
  def get!(msg_id) do
    {:ok, response} = get(msg_id)
    response
  end
end
