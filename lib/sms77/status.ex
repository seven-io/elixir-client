defmodule Sms77.Status do
  @moduledoc "All code regarding endpoint /status belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  def get(msg_id) do
    case HTTPClient.post("status", {:form, [msg_id: msg_id]}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  def get!(msg_id) do
    {:ok, response} = get(msg_id)
    response
  end
end