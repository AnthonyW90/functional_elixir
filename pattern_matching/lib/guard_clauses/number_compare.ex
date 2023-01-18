defmodule NumberCompare do
  # This greater function will only be called if the first argument is greater than or equal to the second argument.
  def greater(number, other_number) when number >= other_number do
    number
  end

  # This greater function will get called if the greater function above doesn't match.
  def greater(_, other_number), do: other_number
end
