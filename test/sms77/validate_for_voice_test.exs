defmodule Sms77.ValidateForVoiceTest do
  @moduledoc "All tests regarding endpoint /validate_for_voice belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.{ValidateForVoice, TestUtil}

  setup_all do
    HTTPoison.start()
  end

  @tag :validate_for_voice
  test "returns a map on success" do
    use_cassette "validate_for_voice" do
      params = %{
        callback: nil,
        number: TestUtil.shared_inbound_eplus(),
      }
      map = ValidateForVoice.post!(params)

      assert true === map.success
    end
  end
end