defmodule Seven.StatusTest do
  @moduledoc "All tests regarding endpoint /status belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Journal, Status, TestUtil}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :status
  test "returns a code on success" do
    use_cassette "status" do
      journals = Journal.get!(%{type: "outbound"})
      journal = List.first(journals)

      text = Status.get!(journal.id)
      lines = TestUtil.split_by_line(text)

      assert 2 === Enum.count(lines)
      assert Enum.fetch!(lines, 0) != "" # "DELIVERED"
      assert Enum.fetch!(lines, 1) != "" # "2021-04-01 12:11:11.000"
    end
  end

  @tag :status_fail
  test "returns an error code" do
    use_cassette "status_fail" do
      assert 600 == Status.get!(0)
    end
  end
end
