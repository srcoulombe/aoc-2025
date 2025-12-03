defmodule AOC do
  def run(module, args) do
    module_name = Module.concat(__MODULE__, module)
    IO.puts("Running #{module_name}")
    module_name.run(args)
  end
end
