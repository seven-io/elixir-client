defmodule Sms77.Analytics do
  @moduledoc "All code regarding endpoint /analytics belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  @type group_by :: :country | :date | :label | :subaccount
  @type params :: {
                    group_by :: String,
                    start :: String,
                    end_ :: String,
                    label :: String,
                    subaccounts :: String,
                  }


  @enforce_keys [:direct, :economy, :hlr, :inbound, :mnp, :usage_eur, :voice]
  defstruct [
    # TODO?
    :account,
    # TODO?
    :country,
    # TODO?
    :date,
    :direct,
    :economy,
    :hlr,
    :inbound,
    # TODO?
    :label,
    :mnp,
    :usage_eur,
    :voice,
  ]

  def new(attributes) do
    %__MODULE__{
      account: attributes[:account], # TODO?
      country: attributes[:country], # TODO?
      date: attributes[:date], # TODO?
      direct: attributes[:direct],
      economy: attributes[:economy],
      hlr: attributes[:hlr],
      inbound: attributes[:inbound],
      label: attributes[:label], # TODO?
      mnp: attributes[:mnp],
      usage_eur: attributes[:usage_eur],
      voice: attributes[:voice],
    }
  end

  def get(params) do
    qs = %{
      end: Map.get(params, "end"),
      group_by: Map.get(params, "group_by"),
      label: Map.get(params, "label"),
      start: Map.get(params, "start"),
      subaccounts: Map.get(params, "subaccounts")
    }
    Enum.each qs, fn {k, v} ->
      if (v === nil) do
        Map.delete(qs, k)
      end
    end

    case HTTPClient.get("analytics", [], params: qs) do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, Enum.map(body, fn a -> new(a) end)}

      {:ok, %Response{status_code: _, body: body}} ->
        {:error, body}

      {:error, error} ->
        {:error, error}
    end
  end

  def get!(params) do
    {:ok, analytics} = get(params)
    analytics
  end
end