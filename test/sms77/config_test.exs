defmodule Sms77.ConfigTest do
  @moduledoc "All tests regarding client config belong here."

  use ExUnit.Case

  alias Sms77.Config

  @tag :config_api_key
  test "should update api_key" do
    Application.put_env(:sms77, :api_key, "your apikey")
    assert Config.api_key!() == "your apikey"
    Application.delete_env(:sms77, :api_key)
  end

  @tag :config_sent_with
  test "should update sent_with" do
    uuid = UUID.uuid4()
    Application.put_env(:sms77, :sent_with, uuid)
    assert Config.sent_with!() == uuid
    Application.delete_env(:sms77, :sent_with)
  end
end