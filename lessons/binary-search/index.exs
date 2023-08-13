defmodule BinarySearch do
  def search(array, item) do
    # recursivity
    do_search(array, item, 0, length(array) - 1)
  end

  # def -> public function
  # defp -> private function

  # this conditions assures you that if your code recursivity or iteration got broken, the -1 index will be returned
  defp do_search(_, _, lower, higher) when lower > higher do
    -1
  end

  defp do_search(array, item, lower, higher) do
    # split the array into a half so we would have /2 options to consider
    middle = div(lower + higher, 2)
    # using enum pointers to tell where we are aiming inside of the array
    guess = Enum.at(array, middle)

    # comparing the logic between the guess and the previous guesses
    case compare(guess, item) do
      # if your guess is equal to the item, you are right
      :equal ->
        middle

      # if your guess is less than the item, you must split your array again after the previous middle
      :less ->
        do_search(array, item, middle + 1, higher)

      # if your guess is greater than the item, you must split your array again before the previous middle
      :greater ->
        do_search(array, item, lower, middle - 1)
    end
  end

  # this function is responsible to make sure that your array will not have any previous items before the ones you are about to insert
  def create_array(0, acc), do: acc

  # this function is responsible to receive the informations from the gen_array and then append its content into an array
  def create_array(n, acc) when n > 0 do
    create_array(n - 1, [n | acc])
  end

  def gen_array() do
    random_number = :rand.uniform(150_000)

    create_array(random_number, [])
  end

  # calls the less condition
  defp compare(a, b) when a < b, do: :less
  # calls the greater condition
  defp compare(a, b) when a > b, do: :greater
  # calls the equal condition
  defp compare(_, _), do: :equal
end

defmodule Main do
  def run() do
    list = BinarySearch.gen_array()
    item = :rand.uniform(length(list))

    IO.puts(Enum.join(["Item: ", item], " "))

    index = BinarySearch.search(list, item)

    if index == -1 do
      IO.puts("Item not found.")
    else
      IO.puts("Item found at index #{index}.")
      IO.inspect(Enum.join(["Complete list", Enum.join(list, ",")], " "))
      IO.puts(Enum.join(["List at [#{index}]:", Enum.at(list, index)], " "))
    end
  end
end

Main.run()
