defmodule AOC.Day2 do
  alias AOC.FileParsing

  def run(path) do
    path
    |> get_puzzle_input()
    |> Enum.map(&adjust_range/1)
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

  def adjust_range({start, stop}) do
    {
      round_to_nearest_candidate(start, :up),
      round_to_nearest_candidate(stop, :down)
    }
  end

  def round_to_nearest_candidate(number, direction) do
    num_digits = count_digits(number)
    if rem(num_digits, 2) == 0 do
      number
    else
      case direction do
        :up ->
          [1] ++ List.duplicate(0, num_digits)
          |> Integer.undigits()
        :down ->
          9
          |> List.duplicate(num_digits - 1)
          |> Integer.undigits()
      end
    end
  end

  def find_invalid_numbers({start, stop}) when start >= stop, do: 0

  def find_invalid_numbers({start, stop}) do
    Range.new(start, stop)
    |> Enum.filter(&is_invalid?/1)
  end

  def is_invalid?(number) do
    digits = Integer.digits(number)

    num_digits = Enum.count(digits)
    if rem(num_digits, 2) == 0 do
      {first_half, second_half} =
        digits
        |> Enum.split(div(num_digits, 2))

      first_half == second_half
    else
      false
    end
  end

  def count_digits(number) when number == 0, do: 1

  def count_digits(number) do
    number
    |> :math.log10()
    |> ceil()
  end
end
