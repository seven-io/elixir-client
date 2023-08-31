defmodule Seven.ValidateForVoiceTest do
  @moduledoc "All tests regarding endpoint /validate_for_voice belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{ValidateForVoice}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :validate_for_voice
  test "returns a map on success" do
    use_cassette "validate_for_voice" do
      params = %{
        callback: nil,
        number: '+491716992343',
      }
      map = ValidateForVoice.post!(params)

      assert true === map.success
    end
  end
end
