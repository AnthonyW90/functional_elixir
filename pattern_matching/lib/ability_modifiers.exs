# IO.gets/1 is a function that reads a line from the standard input
user_input = IO.gets("Write your ability score:\n")

# Integer.parse/1 is a function that parses a string and returns a tuple with the parsed integer and the rest of the string
# The _ is a variable that we don't care about
{ability_score, _} = Integer.parse(user_input)
ability_modifier = (ability_score - 10) / 2

# IO.puts/1 is a function that prints a line to the standard output
IO.puts("Your ability modifier is #{ability_modifier}")
