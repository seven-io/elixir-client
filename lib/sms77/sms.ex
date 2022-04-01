defmodule Sms77.Sms do
  @moduledoc "All code regarding endpoint /sms belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  def delete(params) do
    case HTTPClient.delete("sms?ids=" <> Jason.encode!(params)) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  def delete!(params) do
    {:ok, response} = delete(params)
    response
  end

  def post(params) do
    case HTTPClient.post("sms", {:form, Map.to_list(params)}) do
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