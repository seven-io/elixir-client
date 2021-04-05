ExUnit.start()

defmodule Sms77.TestUtil do
  def get_test_recipient do
    System.get_env("SMS77_RECIPIENT", "491716992343")
  end

  def shared_inbound_eplus do
    "491771783130"
  end

  def split_by_line(text) do
    String.split(text, ["\n", "\r", "\r\n"])
  end
end