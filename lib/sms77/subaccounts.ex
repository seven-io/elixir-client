defmodule Sms77.Subaccounts do
  @moduledoc "All code regarding endpoint /subaccounts belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  @endpoint "subaccounts"

  @spec create(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def create(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(Map.merge(params, %{"action" => "create"}))} ) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec create!(map()) :: map()
  def create!(params) do
    {:ok, response} = create(params)
    response
  end

  @spec delete(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def delete(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(Map.merge(params, %{"action" => "delete"}))} ) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec delete!(map()) :: map()
  def delete!(params) do
    {:ok, response} = delete(params)
    response
  end

  @spec read() :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def read() do
    case HTTPClient.get(@endpoint <> "?action=read") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec read!() :: [map()]
  def read!() do
    {:ok, response} = read()
    response
  end

  @spec transferCredits(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def transferCredits(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(Map.merge(params, %{"action" => "transfer_credits"}))} ) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec transferCredits!(map()) :: map()
  def transferCredits!(params) do
    {:ok, response} = transferCredits(params)
    response
  end

  @spec updateAutomaticCharging(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def updateAutomaticCharging(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(Map.merge(params, %{"action" => "update"}))} ) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec updateAutomaticCharging!(map()) :: map()
  def updateAutomaticCharging!(params) do
    {:ok, response} = updateAutomaticCharging(params)
    response
  end
end