defmodule Seven.Hooks do
  @moduledoc "All code regarding endpoint /hooks belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "hooks"

  @spec get(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def get(params) do
    case HTTPClient.get(@endpoint, [], params: params) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec get!(map()) :: map()
  def get!(params) do
    {:ok, response} = get(params)
    response
  end

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
