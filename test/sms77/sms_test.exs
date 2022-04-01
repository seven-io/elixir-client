defmodule Sms77.SmsTest do
  @moduledoc "All tests regarding endpoint /sms belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.Sms

  setup_all do
    HTTPoison.start()
  end

  @tag :sms_delete
  test "returns an error because no IDs supplied" do
    use_cassette "sms_delete" do
      response = Sms.delete!(%{
        ids: [], # empty list
      })

      assert false === response.success
      assert nil === response.deleted
    end
  end

  @tag :sms_default
  test "returns a code on success" do
    use_cassette "sms_default" do
      assert 100 === Sms.post!(
               %{
                 text: "HI2U!",
                 to: System.get_env("SMS77_RECIPIENT"),
               }
             )
    end
  end

  @tag :sms_json
  test "returns a map on success" do
    use_cassette "sms_json" do
      params = %{
        from: "Elixir",
        json: 1,
        text: "HI2U!",
        to: "+491771783130",
      }
      response = Sms.post!(params)

      assert "true" === response.debug
      assert "direct" === response.sms_type
      assert "100" === response.success
      assert 0 === response.total_price

      for message <- response.messages do
        assert "gsm" === message.encoding
        assert nil === message.error
        assert nil === message.error_text
        assert nil === message.id
        assert nil === message.label
        assert 1 === message.parts
        assert 0 === message.price
        assert String.replace(Map.get(params, :to), "+", "") === message.recipient
        assert Map.get(params, :from) === message.sender
        assert true === message.success
        assert Map.get(params, :text) === message.text
      end
    end
  end
end