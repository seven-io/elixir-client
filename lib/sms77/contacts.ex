defmodule Sms77.Contacts do
  @moduledoc "All code regarding endpoint /contacts belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  @endpoint "contacts"

  def get(params) do
    case HTTPClient.get(@endpoint, [], params: params) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  def get!(params) do
    {:ok, response} = get(params)
    response
  end

  def post(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
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