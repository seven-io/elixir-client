defmodule Sms77.BalanceTest do
  @moduledoc "All tests regarding endpoint /balance belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.Balance

  setup_all do
    HTTPoison.start()
  end

  @tag :balance
  test "returns balance or error" do
    use_cassette "balance" do
      tuple = Balance.get()
      status = elem(tuple, 0)
      value = elem(tuple, 1)

      assert status === :error or status === :ok

       if (status === :ok) do
         assert value >= 0.0
       end
    end
  end

  @tag :balance!
  test "returns balance on success" do
    use_cassette "balance!" do
      float = Balance.get!()
      assert float >= 0.0
    end
  end
end