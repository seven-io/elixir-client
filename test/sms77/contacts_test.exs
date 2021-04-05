defmodule Sms77.ContactsTest do
  @moduledoc "All tests regarding endpoint /contacts belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Sms77.{Contacts, TestUtil}

  setup_all do
    HTTPoison.start()
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

  @tag :contacts_csv_read
  test "returns a CSV of contacts on success" do
    use_cassette "contacts_csv_read" do
      csv = Contacts.get!(%{action: "read"})
      rows = TestUtil.split_by_line(String.trim(csv))

      for row <- rows do
        cols = String.split(String.trim(row), ";")
        assert 3 === Enum.count(cols)
      end
    end
  end

  @tag :contacts_json_create
  test "returns a map on success" do
    use_cassette "contacts_json_create" do
      map = Contacts.get!(%{action: "write", json: 1})

      assert "152" === map.return
      assert 0 < map.id
    end
  end

  @tag :contacts_csv_create
  test "returns the new contact ID on success" do
    use_cassette "contacts_csv_create" do
      text = Contacts.post!(%{action: "write"})
      lines = TestUtil.split_by_line(text)

      assert "152" === Enum.fetch!(lines, 0)
      assert 0 < String.to_integer(Enum.fetch!(lines, 1))
    end
  end

  @tag :contacts_json_edit
  test "json_edit: returns a map on success" do
    use_cassette "contacts_json_edit" do
      map = Contacts.get!(
        %{
          action: "write",
          empfaenger: "+490123456789",
          id: @edit_id,
          json: 1,
          nick: "Tommy Tester"
        }
      )

      assert "152" === map.return
    end
  end

  @tag :contacts_csv_edit
  test "csv_edit: returns a code on success" do
    use_cassette "contacts_csv_edit" do
      assert 152 === Contacts.get!(
               %{
                 action: "write",
                 empfaenger: "+45678901234",
                 id: @edit_id,
                 nick: "Tommy Tester"
               }
             )
    end
  end

  @tag :contacts_json_del
  test "json_del: returns a map on success" do
    use_cassette "contacts_json_del" do
      map = Contacts.get!(
        %{action: "del", id: Contacts.get!(%{action: "write", json: 1}).id, json: 1}
      )

      assert "152" === map.return
    end
  end

  @tag :contacts_csv_del
  test "csv_del: returns a map on success" do
    use_cassette "contacts_csv_del" do
      assert 152 === Contacts.post!(
               %{action: "del", id: Contacts.get!(%{action: "write", json: 1}).id}
             )
    end
  end
end