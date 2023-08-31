defmodule Seven.SubaccountsTest do
  @moduledoc "All tests regarding endpoint /subaccounts belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Subaccounts}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :subaccounts_create_fail
  test "fails to create a subaccount" do
    use_cassette "subaccounts_create_fail" do
      map = Subaccounts.create!(%{
        "email" => "", # can not be empty
        "name" => "", # can not be empty
      })

      assert Map.has_key?(map, :error)
      assert String.length(map[:error]) != 0

      assert Map.has_key?(map, :success)
      assert map[:success] == false
    end
  end

  @tag :subaccounts_delete_fail
  test "fails to delete a subaccount" do
    use_cassette "subaccounts_delete_fail" do
      map = Subaccounts.delete!(%{
        "id" => "", # can not be empty
      })

      assert Map.has_key?(map, :error)
      assert String.length(map[:error]) != 0

      assert Map.has_key?(map, :success)
      assert map[:success] == false
    end
  end

  @tag :subaccounts_read
  test "returns a list of subaccounts" do
    use_cassette "subaccounts_read" do
      subaccounts = Subaccounts.read!()

      for subaccount <- subaccounts do
        assert Map.has_key?(subaccount, :id)
        assert Map.has_key?(subaccount, :username)
        assert Map.has_key?(subaccount, :company)
        assert Map.has_key?(subaccount, :total_usage)
        assert Map.has_key?(subaccount, :auto_topup)
        assert Map.has_key?(subaccount[:auto_topup], :threshold)
        assert Map.has_key?(subaccount[:auto_topup], :amount)
        assert Map.has_key?(subaccount, :contact)
        assert Map.has_key?(subaccount[:contact], :name)
        assert Map.has_key?(subaccount[:contact], :email)
      end
    end
  end

  @tag :subaccounts_transfer_credits_fail
  test "fails to transfer credits for subaccount" do
    use_cassette "subaccounts_transfer_credits_fail" do
      map = Subaccounts.transferCredits!(%{
        "amount" => "", # can not be empty
        "id" => "", # can not be empty
      })

      assert Map.has_key?(map, :error)
      assert String.length(map[:error]) != 0

      assert Map.has_key?(map, :success)
      assert map[:success] == false
    end
  end

  @tag :subaccounts_update_automatic_charging_fail
  test "fails to update automatic charging for subaccount" do
    use_cassette "subaccounts_update_automatic_charging_fail" do
      map = Subaccounts.updateAutomaticCharging!(%{
        "amount" => "", # can not be empty
        "id" => "", # can not be empty
        "threshold" => "", # can not be empty
      })

      assert Map.has_key?(map, :error)
      assert String.length(map[:error]) != 0

      assert Map.has_key?(map, :success)
      assert map[:success] == false
    end
  end
end
