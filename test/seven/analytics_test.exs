defmodule Seven.AnalyticsTest do
  @moduledoc "All tests regarding endpoint /analytics belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.Analytics

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :analytics_grouped_by_country
  test "returns a list of analytics grouped by country" do
    use_cassette "analytics_grouped_by_country" do
      for analytic <- Analytics.groupedByCountry!() do
        assert Map.has_key?(analytic, :country)
      end
    end
  end

  @tag :analytics_group_by_country
  test "returns a list of analytics grouped by country on success" do
    use_cassette "analytics_group_by_country" do
      for analytic <- Analytics.get!(%{"group_by" => "country"}) do
        assert Map.has_key?(analytic, :country)
      end
    end
  end

  @tag :analytics_group_by_date
  test "returns a list of analytics grouped by date on success" do
    use_cassette "analytics_group_by_date" do
      for analytic <- Analytics.get!(%{"group_by" => "date"}) do
        assert Map.has_key?(analytic, :date)
      end
    end
  end

  @tag :analytics_group_by_subaccount
  test "returns a list of analytics grouped by subaccount on success" do
    use_cassette "analytics_group_by_subaccount" do
      for analytic <- Analytics.get!(%{"group_by" => "subaccount"}) do
        assert Map.has_key?(analytic, :account)
      end
    end
  end

  @tag :analytics_group_by_label
  test "returns a list of analytics grouped by label on success" do
    use_cassette "analytics_group_by_label" do
      for analytic <- Analytics.get!(%{"group_by" => "label"}) do
        assert Map.has_key?(analytic, :label)
      end
    end
  end

  @tag :analytics_group_by_label_for_label
  test "returns a list of analytics grouped by label for a certain label on success" do
    use_cassette "analytics_group_by_label_for_label" do
      for analytic <- Analytics.get!(%{group_by: "label", label: "xxx"}) do
        assert Map.has_key?(analytic, :label)
      end
    end
  end
end
