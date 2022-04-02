defmodule Sms77.Subaccounts do
  @moduledoc "All code regarding endpoint /subaccounts belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  @endpoint "subaccounts"

  def create(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(Map.merge(params, %{"action" => "create"}))} ) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  def create!(params) do
    {:ok, response} = create(params)
    response
  end

  def delete(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(Map.merge(params, %{"action" => "delete"}))} ) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  def delete!(params) do
    {:ok, response} = delete(params)
    response
  end

  def read() do
    case HTTPClient.get(@endpoint <> "?action=read") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  def read!() do
    {:ok, response} = read()
    response
  end

  def transferCredits(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(Map.merge(params, %{"action" => "transfer_credits"}))} ) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  def transferCredits!(params) do
    {:ok, response} = transferCredits(params)
    response
  end

  def updateAutomaticCharging(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(Map.merge(params, %{"action" => "update"}))} ) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  def updateAutomaticCharging!(params) do
    {:ok, response} = updateAutomaticCharging(params)
    response
  end
end