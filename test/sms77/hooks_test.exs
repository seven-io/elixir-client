defmodule Sms77.HooksTest do
  @moduledoc "All tests regarding endpoint /hooks belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.Hooks

  setup_all do
    HTTPoison.start()
  end

  @tag :hooks_read
  test "returns a list of hooks on success" do
    use_cassette "hooks_read" do
      params = %{
        action: "read",
      }
      map = Hooks.get!(params)

      assert true === map.success

      for hook <- map.hooks do
        assert Map.has_key?(hook, :id)
        assert Map.has_key?(hook, :target_url)
        assert Map.has_key?(hook, :event_type)
        assert Map.has_key?(hook, :request_method)
        assert Map.has_key?(hook, :created)
      end
    end
  end

  @tag :hooks_subscribe_fail
  test "subscribe_fail: returns a map on success" do
    use_cassette "hooks_subscribe_fail" do
      params = %{
        action: "subscribe",
        event_type: "all",
        target_url: "ThisShouldBeAUrl",
      }
      map = Hooks.post!(params)

      assert false === map.success
      assert false === Map.has_key?(map, :id)
    end
  end

  @tag :hooks_subscribe
  test "subscribe: returns a map on success" do
    use_cassette "hooks_subscribe" do
      map = Hooks.post!(
        %{
          action: "subscribe",
          event_type: "all",
          request_method: "POST",
          target_url: "https://my.tld/#{UUID.uuid4()}",
        }
      )

      assert true === map.success
      assert 0 < map.id
    end
  end

  @tag :hooks_unsubscribe
  test "unsubscribe: returns a map on success" do
    use_cassette "hooks_unsubscribe" do
      assert true === Hooks.post!(
               %{
                 action: "unsubscribe",
                 id: Hooks.post!(
                   %{
                     action: "subscribe",
                     event_type: "all",
                     request_method: "POST",
                     target_url: "https://my.tld/#{UUID.uuid4()}",
                   }
                 ).id,
               }
             ).success
    end
  end
end