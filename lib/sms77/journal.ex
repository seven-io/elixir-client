defmodule Sms77.Journal do
  @moduledoc "All code regarding endpoint /journal belongs here."

  alias HTTPoison.Response
  alias Sms77.HTTPClient

  @endpoint "journal"

  @enforce_keys [:from, :id, :price, :text, :timestamp, :to]
  defstruct [
    :connection,
    :dlr,
    :dlr_timestamp,
    :duration,
    :error,
    :foreign_id,
    :from,
    :id,
    :label,
    :latency,
    :mccmnc,
    :price,
    :status,
    :text,
    :timestamp,
    :to,
    :type,
    :xml,
  ]

  def new(attributes) do
    %__MODULE__{
      connection: attributes[:connection],
      dlr: attributes[:dlr],
      dlr_timestamp: attributes[:dlr_timestamp],
      duration: attributes[:duration],
      error: attributes[:error],
      foreign_id: attributes[:foreign_id],
      from: attributes[:from],
      id: attributes[:id],
      label: attributes[:label],
      latency: attributes[:latency],
      mccmnc: attributes[:mccmnc],
      price: attributes[:price],
      status: attributes[:status],
      text: attributes[:text],
      timestamp: attributes[:timestamp],
      to: attributes[:to],
      type: attributes[:type],
      xml: attributes[:xml],
    }
  end

  @spec get(map()) :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def get(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "?" <> qs) do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, Enum.map(body, fn a -> new(a) end)}

      {:ok, %Response{status_code: _, body: body}} ->
        {:error, body}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec get!(map()) :: [map()]
  def get!(params) do
    {:ok, analytics} = get(params)
    analytics
  end
end