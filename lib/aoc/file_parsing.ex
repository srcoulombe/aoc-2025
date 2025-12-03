defmodule AOC.FileParsing do
  def read_file_content(path) do
    IO.puts("Reading #{path}")
    case File.read(path) do
      {:ok, content} ->
        content
      {:error, error} ->
        raise error
    end
  end
end
