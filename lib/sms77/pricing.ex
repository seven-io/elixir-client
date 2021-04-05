defmodule Sms77.Pricing do
  @moduledoc "All code regarding endpoint /pricing belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  def get(params) do
    #    qs = %{
    #      country: Map.get(params, :country),
    #      format: Map.get(params, :format),
    #    }

    case HTTPClient.get("pricing", [], params: params) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  def get!(params) do
    {:ok, response} = get(params)
    response
  end
end