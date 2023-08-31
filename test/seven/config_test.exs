defmodule Seven.ConfigTest do
  @moduledoc "All tests regarding client config belong here."

  use ExUnit.Case

  alias Seven.Config

  @tag :config_api_key
  test "should update api_key" do
    Application.put_env(:seven, :api_key, "your apikey")
    assert Config.api_key!() == "your apikey"
    Application.delete_env(:seven, :api_key)
  end

  @tag :config_sent_with
  test "should update sent_with" do
    uuid = UUID.uuid4()
    Application.put_env(:seven, :sent_with, uuid)
    assert Config.sent_with!() == uuid
    Application.delete_env(:seven, :sent_with)
  end
end
