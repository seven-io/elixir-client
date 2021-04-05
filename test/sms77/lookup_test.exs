defmodule Sms77.LookupTest do
  @moduledoc "All tests regarding endpoint /lookup belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.{Lookup, TestUtil}

  setup_all do
    HTTPoison.start()
  end

  @tag :lookup_format
  test "format: returns a map on success" do
    use_cassette "lookup_formatt" do
      params = %{
        number: TestUtil.shared_inbound_eplus(),
        type: "format",
      }
      map = Lookup.post!(params)

      assert "Eplus" === map.carrier
      assert "49" === map.country_code
      assert "DE" === map.country_iso
      assert "Germany" === map.country_name
      assert "+491771783130" === map.international
      assert "+49 177 1783130" === map.international_formatted
      assert "0177 1783130" === map.national
      assert "mobile" === map.network_type
      assert true === map.success
    end
  end

  @tag :lookup_mnp_json
  test "mnp: returns a map on success" do
    use_cassette "lookup_mnp_json" do
      params = %{
        json: 1,
        number: TestUtil.shared_inbound_eplus(),
        type: "mnp",
      }
      map = Lookup.post!(params)

      assert 100 === map.code
      assert "DE" === map.mnp.country
      assert "+49 177 1783130" === map.mnp.international_formatted
      assert false === map.mnp.isPorted
      assert "26203" === map.mnp.mccmnc
      assert "0177 1783130" === map.mnp.national_format
      assert "Telefónica Germany GmbH & Co. oHG (O2)" === map.mnp.network
      assert "+491771783130" === map.mnp.number
      assert 0.005 === map.price
      assert true === map.success
    end
  end

  @tag :lookup_mnp_text
  test "mnp: returns the operator on success" do
    use_cassette "lookup_mnp_text" do
      params = %{
        number: TestUtil.shared_inbound_eplus(),
        type: "mnp",
      }
      text = Lookup.post!(params)

      assert "eplus" === text
    end
  end

  @tag :lookup_hlr
  test "hlr: returns a map on success" do
    use_cassette "lookup_hlr" do
      params = %{
        number: TestUtil.shared_inbound_eplus(),
        type: "hlr",
      }
      map = Lookup.post!(params)

      assert "DE" === map.country_code
      assert "Germany" === map.country_name
      assert "49" === map.country_prefix
      assert "DE" === map.current_carrier.country
      assert "Telefónica Germany GmbH & Co. oHG (O2)" === map.current_carrier.name
      assert "26207" === map.current_carrier.network_code
      assert "mobile" === map.current_carrier.network_type
      assert "0" === map.gsm_code
      assert "No error" === map.gsm_message
      assert "491771783130" === map.international_format_number
      assert "+49 177 1783130" === map.international_formatted
      assert true === map.lookup_outcome
      assert "success" === map.lookup_outcome_message
      assert "0177 1783130" === map.national_format_number
      assert "DE" === map.original_carrier.country
      assert "Telefónica Germany GmbH & Co. oHG (O2)" === map.original_carrier.name
      assert "26207" === map.original_carrier.network_code
      assert "mobile" === map.original_carrier.network_type
      assert "assumed_not_ported" === map.ported
      assert "reachable" === map.reachable
      assert "not_roaming" === map.roaming
      assert true === map.status
      assert "success" === map.status_message
      assert "valid" === map.valid_number
    end
  end

  @tag :lookup_cnam
  test "cnam: returns a map on success" do
    use_cassette "lookup_cnam" do
      params = %{
        number: TestUtil.shared_inbound_eplus(),
        type: "cnam",
      }
      map = Lookup.post!(params)

      assert "100" === map.code
      assert "GERMANY" === map.name
      assert "+491771783130" === map.number
      assert "true" === map.success
    end
  end
end