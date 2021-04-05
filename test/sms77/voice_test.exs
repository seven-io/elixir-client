defmodule Sms77.VoiceTest do
  @moduledoc "All tests regarding endpoint /voice belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.{TestUtil, Voice}

  setup_all do
    HTTPoison.start()
  end

  @tag :voice_json
  test "returns a map on success" do
    use_cassette "voice_json" do
      params = %{
        json: 1,
        text: "HI2U!",
        to: TestUtil.get_test_recipient(),
      }
      response = Voice.post!(params)

      assert true === response.debug
      assert "100" === response.success
      assert 0 === response.total_price
      assert Map.has_key?(response, :balance)

      for message <- response.messages do
        assert nil === message.error
        assert nil === message.error_text
        assert "123456789" === message.id
        assert 0 === message.price
        assert String.replace(Map.get(params, :to), "+", "") === message.recipient
        assert TestUtil.shared_inbound_eplus() === message.sender
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
        to: TestUtil.get_test_recipient(),
      }
      split = TestUtil.split_by_line(Voice.post!(params))

      assert 3 === Enum.count(split)
      assert "100" === Enum.fetch!(split, 0)
      assert "123456789" === Enum.fetch!(split, 1)
      assert "0" === Enum.fetch!(split, 2)
    end
  end
end