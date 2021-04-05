defmodule Sms77.Balance do
  @moduledoc "All code regarding endpoint /balance belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  def get() do
    case HTTPClient.get("balance") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  def get!() do
    {:ok, balance} = get()
    balance
  end
end