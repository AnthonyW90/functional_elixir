# Pattern Matching

## Pattern Matching in Elixir

Elixir uses pattern matching to match values to variables. This is similar to the `=` operator in other languages.

```elixir
iex> x = 1
1
iex> 1 = x
1
iex> 2 = x
** (MatchError) no match of right hand side value: 1
```

The `=` operator is used to match the value on the right to the variable on the left. The value on the right is evaluated first, then the value on the left is matched to the value on the right.

## Unpacking Values

Pattern matching can be used to extract values from variables. This is similar to destructuring in other languages.

```elixir
iex> [x, y] = [1, 2]
[1, 2]
iex> x
1
iex> y
2
```

### Matching Parts of a String

Pattern matching can be used to match parts of a string. This can be used to extract part of a string.

```elixir
iex> "Hello" <> rest = "Hello World"
iex> rest
" World"
```

> Note: We can't use a variable on the left side of the `<>` operator.

### Matching Tuples

Pattern matching can be used to match parts of a tuple. This can be used to extract part of a tuple.

```elixir
iex> {x, y} = {1, 2}
{1, 2}
iex> x
1
iex> y
2
```

Tuples are useful for signaling success or failure. For example, we can use a tuple to signal success or failure of a function.

```elixir
defmodule Math do
  def add(x, y) do
    { :ok, x + y }
  end
end
```

```elixir
iex> {:ok, sum} = Math.add(1, 2)
{:ok, 3}
iex> sum
3
```

Here  we have a function `add` that takes two arguments, `x` and `y`, and returns a tuple. The first element of the tuple is an atom, `:ok`, and the second element is the sum of the two arguments. We can use pattern matching to extract the sum from the tuple.

[/lib/ability_modifiers.exs](./lib/ability_modifers.exs)
```elixir
user_input = IO.gets("Write your ability score:\n")
{ability_score, _} = Integer.parse(user_input)
ability_modifier = (ability_score - 10) / 2
IO.puts("Your ability modifier is #{ability_modifier}")
```
We can run this file by calling `elixir ability_modifiers.exs` in the terminal.
```shell
Write your ability score:
16
Your ability modifier is 3.0
```

### Matching Lists

Pattern matching can be used to match parts of a list. This can be used to extract part of a list.


```elixir
iex> [a, a, a] = [1, 1, 1]
[1, 1, 1]
iex> a
1
```

```elixir
iex> [a, a, a] = [1, 2, 1]
** (MatchError) no match of right hand side value: [1, 2, 1]
```

The | operator can be used to match the head of a list. The right side of the | operator is a variable that will match the tail of the list.

```elixir
iex> [x | rest] = [1, 2, 3]
[1, 2, 3]
iex> x
1
iex> rest
[2, 3]
```

### Matching Maps

```elixir
iex> abilities = %{strength: 16, dexterity: 12, intelligence: 10}
iex> %{strength: strength_value} = abilities
iex> strength_value
16
```

Here we have a map with three keys, `:strength`, `:dexterity`, and `:intelligence`. We can use pattern matching to extract the value of the `:strength` key.

If we use an empty map, it will match all maps. For example:

```elixir
iex> %{} = abilities
%{dexterity: 12, intelligence: 10, strength: 16}
iex> %{} = %{a: 1, b: 2}
%{a: 1, b: 2}
```

We can even pattern matching to check values in a map.

```elixir
iex> %{strength: 16} = abilities
%{dexterity: 12, intelligence: 10, strength: 16}
iex> %{strength: 16} = %{strength: 12}
** (MatchError) no match of right hand side value: %{strength: 12}
```

### Matching Structs

Structs are similar to maps, but they have a defined set of keys. We can use pattern matching to extract values from structs.

```elixir
iex> date = ~D[2023-01-01]
~D[2023-01-01]
iex> %{year: year} = date
iex> year
2023
```

`~D` is a Date sigil. It is used to create a Date struct. We can use pattern matching to extract the year from the struct.

There are other sigils for creating structs. For example, `~w` is a sigil for creating a list of words.

```elixir
iex> ~w[hello world]
["hello", "world"]
```

The difference between a struct and a map is that a struct has a defined set of keys. For example, we can't add a new key to a struct.

### Control flow with Functions

We can use pattern matching to control the flow of a function. For example, we can use pattern matching to return different values based on the arguments.

```elixir
defmodule Math do
  def add(x, y) do
    x + y
  end

  def add(x, y, z) do
    x + y + z
  end
end
```

```elixir
iex> Math.add(1, 2)
3
iex> Math.add(1, 2, 3)
6
```

Here we have a module `Math` with two functions, `add/2` and `add/3`. The first function takes two arguments, and the second function takes three arguments. We can call these functions with two or three arguments.

[/lib/number_compare.ex](./lib/number_compare.ex)
```elixir
defmodule NumberCompare do
  def greater(number, other_number) do
    check(number >= other_number, number, other_number)
  end

  def greater(number, other_number) do
    check(number >= other_number, number, other_number)
  end

  defp check(true, number, _), do: number
  defp check(false, _, other_number), do: other_number
end
```

```shell
iex> NumberCompare.greater(1, 2)
2
iex> NumberCompare.greater(2, 1)
2
```

The greater function uses the >= operator to compare two numbers and determine whether the first number is greater than or equal to the second number. To handle the two possible outcomes, true or false, an auxiliary function called check was created. Two versions of check were created, one to handle the true case and the other to handle the false case. This is possible because in Elixir, the arguments in a function can be pattern-matching expressions.

### Guard Clauses

Guard clauses are used to control the flow of a function. They are used to check whether the arguments of a function match a certain condition. If the arguments match the condition, the function is executed. If the arguments do not match the condition, an error is raised.

```elixir
defmodule Math do
  def add(x, y) when is_number(x) and is_number(y) do
    x + y
  end
end
```

```elixir
iex> Math.add(1, 2)
3
iex> Math.add(1, :two)
** (FunctionClauseError) no function clause matching in Math.add/2
```


Here is another example:
[/lib/guard_clauses/number_compare.ex](./lib/guard_clauses/number_compare.ex)
```elixir
defmodule NumberCompare do
  def greater(number, other_number) when number >= other_number do
    number
  end

  def greater(_, other_number), do: other_number
end
```

```elixir
iex> NumberCompare.greater(1, 2)
2
iex> NumberCompare.greater(2, 1)
2
```

Guard Clauses can be used to create better function signatures. For example, we can use guard clauses to check whether the arguments are numbers.

[/lib/guard_clauses/checkout.ex](./lib/guard_clauses/checkout.ex)
```elixir
defmodule Checkout do
  def total_cost(price, tax_rate) when price >= 0 and tax_rate >= 0 do
    price * (1 + tax_rate)
  end
end
```
> `price >= 0` and `tax_rate >= 0` are guard clauses. They are used to check whether the arguments are greater than or equal to zero.

```elixir
iex> Checkout.total_cost(10, 0.1)
11.0
iex> Checkout.total_cost(-10, 0.1)
** (FunctionClauseError) no function clause matching in Checkout.total_cost/2
```

## Control Flow

### Case

Case is used to match a value against a series of patterns. If a pattern matches, the corresponding expression is evaluated.

```elixir
case value do
  pattern1 -> expression1
  pattern2 -> expression2
  pattern3 -> expression3
  ...
end
```

```elixir
iex> case :ok do
...>   :ok -> "It's ok"
...>   :error -> "An error has occurred"
...> end
"It's ok"
```

### Cond

Cond is used to evaluate a series of expressions. If an expression evaluates to true, the corresponding expression is evaluated.

```elixir
cond do
  expression1 -> expression1
  expression2 -> expression2
  expression3 -> expression3
  ...
end
```

```elixir
iex> cond do
...>   1 + 1 == 3 -> "This will not be true"
...>   2 * 5 == 12 -> "Nor this"
...>   1 + 2 == 3 -> "But this will"
...> end
"But this will"
```

### If

If is used to evaluate a single expression. If the expression evaluates to true, the corresponding expression is evaluated.

```elixir
if expression do
  expression
end
```

```elixir
iex> if true do
...>   "This will be true"
...> end
"This will be true"
```

### Unless

Unless is used to evaluate a single expression. If the expression evaluates to false, the corresponding expression is evaluated.

```elixir
unless expression do
  expression
end
```

```elixir
iex> unless false do
...>   "This will be true"
...> end
"This will be true"
```