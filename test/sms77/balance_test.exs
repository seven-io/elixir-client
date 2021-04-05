defmodule Sms77.BalanceTest do
  @moduledoc "All tests regarding endpoint /balance belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.Balance

  setup_all do
    HTTPoison.start()
  end

  @tag :balance
  test "returns balance on success" do
    use_cassette "balance" do
      assert {:ok, _} = Balance.get()
    end
  end
end