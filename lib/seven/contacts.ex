defmodule Seven.Contacts do
  @moduledoc "All code regarding endpoint /contacts belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "contacts"

  @spec get(map()) :: {:ok, any()} | {:error, HTTPoison.Error | any()}
  def get(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "?" <> qs) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec get!(map()) :: any()
  def get!(params) do
    {:ok, response} = get(params)
    response
  end

  @spec post(map()) :: {:ok, any()} | {:error, HTTPoison.Error | any()}
  def post(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec post!(map()) :: any()
  def post!(params) do
    {:ok, response} = post(params)
    response
  end
end
