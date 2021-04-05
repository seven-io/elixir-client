defmodule Sms77.StatusTest do
  @moduledoc "All tests regarding endpoint /status belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.{Status, TestUtil}

  setup_all do
    HTTPoison.start()
  end

  @tag :status
  test "returns a code on success" do
    use_cassette "status" do
      text = Status.get!(77137151122)
      lines = TestUtil.split_by_line(text)

      assert 2 === Enum.count(lines)
      assert "DELIVERED" === Enum.fetch!(lines, 0)
      assert "2021-04-01 12:11:11.000" === Enum.fetch!(lines, 1)
    end
  end

  @tag :status_fail
  test "returns an error code" do
    use_cassette "status_fail" do
      assert 901 === Status.get!(0)
    end
  end
end