defmodule AOC.Day1Test do
  use ExUnit.Case
  import AOC.Day1

  describe "get_puzzle_input" do
    test "works and filters out empty lines in the puzzle input file" do
      expected = [
        {"L", 68},
        {"L", 30},
        {"R", 48},
        {"L", 5},
        {"R", 60},
        {"L", 55},
        {"L", 1},
        {"L", 99},
        {"R", 14},
        {"L", 82}
      ]

      assert expected == get_puzzle_input("fixtures/day_1/input.txt")
    end
  end

  describe "to_operation" do
    test "returns a function" do
      assert is_function(to_operation({"L", 1}))
    end
  end

  describe "add" do
    test "identifies when the result is 0" do
      {new_number, zero_counter} = add(0).({0, 1})

      assert 0 == new_number
      assert 2 == zero_counter
    end

    test "identifies when the result is 100" do
      {new_number, zero_counter} = add(1).({99, 0})

      assert 0 == new_number
      assert 1 == zero_counter
    end

    test "handles adding 0 to 0" do
      {new_number, zero_counter} = add(0).({0, 1})

      assert 0 == new_number
      assert 2 == zero_counter
    end

    test "handles result > 100" do
      {new_number, zero_counter} = add(2).({99, 123})

      assert 1 == new_number
      assert 123 == zero_counter
    end

    test "handles result normally" do
      {new_number, zero_counter} = add(2).({12, 0})

      assert 14 == new_number
      assert 0 == zero_counter
    end
  end

  describe "subtract" do
    test "identifies when the result is 0" do
      {new_number, zero_counter} = subtract(1).({1, 0})

      assert 0 == new_number
      assert 1 == zero_counter
    end

    test "handles subtracting 0 from 0" do
      {new_number, zero_counter} = subtract(0).({0, 1})

      assert 0 == new_number
      assert 2 == zero_counter
    end

    test "handles result < 0" do
      {new_number, zero_counter} = subtract(2).({1, 1})

      assert 99 == new_number
      assert 1 == zero_counter
    end
  end
end
