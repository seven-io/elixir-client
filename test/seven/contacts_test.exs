defmodule Seven.ContactsTest do
  @moduledoc "All tests regarding endpoint /contacts belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Contacts, TestUtil}

  setup_all do
    HTTPoison.start
    :ok
  end

  @edit_id 5720527

  @tag :contacts_json_read
  test "returns a list of contacts on success" do
    use_cassette "contacts_json_read" do
      list = Contacts.get!(%{action: "read", json: 1})

      for contact <- list do
        assert 0 < String.to_integer(Map.get(contact, :ID))
        assert Map.has_key?(contact, :Name)
        assert Map.has_key?(contact, :Number)
      end
    end
  end

  @tag :contacts_json_create
  test "returns a map on success" do
    use_cassette "contacts_json_create" do
      map = Contacts.get!(%{action: "write", json: 1})
      Contacts.get!(%{action: "del", id: map.id})

      assert "152" === map.return
      assert 0 < map.id
    end
  end

  @tag :contacts_json_edit
  test "json_edit: returns a map on success" do
    use_cassette "contacts_json_edit" do
      contact = Contacts.get!(%{action: "write", json: 1})

      map = Contacts.get!(%{action: "write", id: contact.id, nick: "Name #{System.os_time()}"})

      assert "152" === map.return
    end
  end

  @tag :contacts_json_del
  test "json_del: returns a map on success" do
    use_cassette "contacts_json_del" do
      contact = Contacts.get!(%{action: "write", json: 1})
      map = Contacts.get!(%{action: "del", id: contact.id, json: 1})

      assert "152" === map.return
    end
  end
end
