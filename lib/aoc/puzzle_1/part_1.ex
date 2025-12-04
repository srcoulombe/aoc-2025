defmodule AOC.Puzzle1.Part1 do
  alias AOC.FileParsing

  def run(path) do
    operations = path
      |> get_puzzle_input()
      |> Enum.map(&to_operation/1)

    {_, result} =
      operations
      |> Enum.reduce({50, 0}, fn operation, acc -> operation.(acc) end)

    IO.puts(result)
  end

  def get_puzzle_input(path) do
    path
    |> FileParsing.read_file_content()
    |> String.split("\n")
    |> Enum.map(fn line ->
      if line != "" do
        {direction, distance} = String.split_at(line, 1)

        {direction, String.to_integer(distance)}
      end
    end)
    |> Enum.filter(fn directive -> !is_nil(directive) end)
  end

  def to_operation({direction, distance}) do
    case {direction, distance} do
      {"L", distance} -> subtract(distance)
      {"R", distance} -> add(distance)
    end
  end

  def add(number) do
    fn ({previous_number, zero_counter}) ->
      new_number = rem(previous_number + number, 100)
      cond do
        new_number == 0 || new_number == 100 ->
          {0, zero_counter + 1}

        new_number > 100 ->
          {new_number - 100, zero_counter}

        true ->
          {new_number, zero_counter}
      end
    end
  end

  def subtract(number) do
    fn ({previous_number, zero_counter}) ->
      new_number = rem(previous_number - number, 100)
      cond do
        new_number == 0 ->
          {new_number, zero_counter + 1}

        new_number < 0 ->
          {100 + new_number, zero_counter}

        true ->
          {new_number, zero_counter}
      end
    end
  end
end
