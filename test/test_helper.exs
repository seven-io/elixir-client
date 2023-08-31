ExUnit.start()

defmodule Seven.TestUtil do
  def split_by_line(text) do
    String.split(text, ["\n", "\r", "\r\n"])
  end
end
