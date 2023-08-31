defmodule Seven.PricingTest do
  @moduledoc "All tests regarding endpoint /pricing belong here."


  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Pricing, TestUtil}

  setup_all do
    HTTPoison.start()
  end

  @tag :pricing_json_all
  test "pricing_json_all: returns a map on success" do
    use_cassette "pricing_json_all" do
      map = Pricing.get!(%{})

      assert 0 <= map.countCountries
      assert 0 <= map.countNetworks
      assert Enum.count(map.countries) === map.countCountries

      for country <- map.countries do
        assert country.countryCode
        assert country.countryName
        assert country.countryPrefix

        for network <- country.networks do
          if network.comment != nil do
            assert network.comment
          end

          for feature <- network.features do
            assert feature
          end
          assert network.mcc

          if Enumerable.impl_for(network.mncs) do
            for mncs <- network.mncs do
              assert mncs
            end
          end

          if network.networkName != nil do
            assert network.networkName
          end

          assert network.price
        end
      end
    end
  end

  @tag :pricing_csv_de
  test "pricing_csv_de: returns CSV on success" do
    use_cassette "pricing_csv_de" do
      csv = String.trim(Pricing.get!(%{country: "de", format: "csv"}))

      for row <- TestUtil.split_by_line(csv) do
        cols = String.split(String.trim(row), ";")
        cols_count = Enum.count(cols)
        assert 10 === cols_count || 9 === cols_count
      end
    end
  end
end
