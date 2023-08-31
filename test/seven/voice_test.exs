defmodule Seven.VoiceTest do
  @moduledoc "All tests regarding endpoint /voice belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{TestUtil, Voice}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :voice_json
  test "returns a map on success" do
    use_cassette "voice_json" do
      params = %{
        json: 1,
        text: "HI2U!",
        to: "491716992343",
      }
      response = Voice.post!(params)

      assert Map.has_key?(response, :debug)
      assert "100" === response.success
      assert 0 <= response.total_price
      assert Map.has_key?(response, :balance)

      for message <- response.messages do
        assert nil === message.error
        assert nil === message.error_text
        assert Regex.match?(~r/^\d+$/, to_string(message.id))
        assert Map.has_key?(message, :id)
        assert 0 <= message.price
        assert String.replace(Map.get(params, :to), "+", "") === message.recipient
        assert Map.has_key?(message, :sender)
        assert true === message.success
        assert Map.get(params, :text) === message.text
      end
    end
  end

  @tag :voice_text
  test "returns 3 text lines on success" do
    use_cassette "voice_text" do
      params = %{
        text: "HI2U!",
        to: "491716992343",
      }
      split = TestUtil.split_by_line(Voice.post!(params))

      assert 3 === Enum.count(split)
      assert "100" === Enum.fetch!(split, 0)
      assert Regex.match?(~r/^\d+$/, Enum.fetch!(split, 1))
      assert Regex.match?(~r/^\d*\.?\d*$/, Enum.fetch!(split, 2))
    end
  end
end
