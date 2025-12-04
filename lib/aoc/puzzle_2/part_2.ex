defmodule AOC.Puzzle2.Part2 do
  alias AOC.FileParsing

  def run(path) do
    path
    |> get_puzzle_input()
    |> Enum.filter(fn {start, stop} -> start <= stop end)
    |> Enum.flat_map(&find_invalid_numbers/1)
    |> Enum.reduce(0, fn invalid_number, acc -> acc + invalid_number end)
    |> IO.puts()
  end

  def get_puzzle_input(path) do
    path
    |> FileParsing.read_file_content()
    |> String.split(",")
    |> Enum.map(fn range ->
      [start, stop] = String.split(range, "-")
      {String.to_integer(start), String.to_integer(stop)}
    end)
  end

  def find_invalid_numbers({start, stop}) when start >= stop, do: 0

  def find_invalid_numbers({start, stop}) do
    Range.new(start, stop)
    |> Enum.to_list()
    |> Enum.filter(&is_invalid?/1)
  end

  def is_invalid?(number) when number < 10, do: false

  def is_invalid?(number) do
    number_as_string = Integer.to_string(number)
    num_digits = String.length(number_as_string)

    Enum.to_list(1..div(num_digits,2))
    |> Enum.any?(fn size ->
      pattern =
        number_as_string
        |> String.slice(0, size)

      rest =
        number_as_string
        |> String.slice(size, num_digits - size)

      num_matches =
        Regex.compile(pattern)
        |> elem(1)
        |> Regex.scan(rest)
        |> Enum.count()

      num_matches == ((num_digits - size) / size)
    end)
  end
end
