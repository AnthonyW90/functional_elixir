# Working with Variables and Functions

## Datatypes:
| Type | Used for | Example |
| ---- | -------- | ------- |
| Integer | Whole numbers | 1, 2, 3 |
| Float | Decimal numbers | 1.0, 2.0, 3.0 |
| Boolean | True or False | true, false |
| Atom | Identifiers | :ok, :error |
| String | Text | "Hello", "World" |
| List | Ordered collection of values (unknown size) | [1, 2, 3], ["Hello", "World"] |
| Tuple | Ordered collection of values (fixed size) | {1, 2, 3}, {"Hello", "World"} |
| Map | Key-value pairs | %{name: "John", age: 27}, %{:brand => "Nike} |
| Keyword List | List of tuples with atom keys | [name: "John", age: 27] |
| Function | Code that can be called | fn x -> x + 1 end |
| Nil | Empty value | nil |


Code can be executed in a REPL using the `iex` command.
```elixir
iex> 1 + 1
```

## Operators:
| Operator | Description | Example |
| -------- | ----------- | ------- |
| + | Addition | 1 + 1 |
| - | Subtraction | 1 - 1 |
| * | Multiplication | 1 * 1 |
| / | Division | 1 / 1 |
| == | Equality | 1 == 1 |
| != | Inequality | 1 != 1 |
| > | Greater than | 1 > 1 |
| < | Less than | 1 < 1 |
| >= | Greater than or equal to | 1 >= 1 |
| <= | Less than or equal to | 1 <= 1 |
| and | Logical AND | true and false |
| or | Logical OR | true or false |
| && | Logical AND (can be used with any datatype)| true && false |
| \|\| | Logical OR (can be used with any datatype) | true \|\| false |
| ! | Logical NOT (can be used with any datatype) | !true |
| ++ | Concatenate lists | [1, 2] ++ [3, 4] |
| -- | Remove elements from a list | [1, 2, 3, 4] -- [2, 4] |
| <> | Concatenate strings | "Hello" <> "World" |


## Logical Expressions

`and`, `or`, and `not` are used for boolean expressions. These must be used with true/false values.
```elixir
iex> true and true
true
iex> true and false
false
iex> true or false
true
iex> not true
false
```

`&&`, `||`, and `!` can be used with any datatype.
```elixir
iex> nil && 1
nil
iex> true && "Hello"
"Hello"
iex> "Hello" && true
true
iex> nil || 1
1
iex> true || "Hello"
true
iex> "Hello" || true
"Hello"
iex> !true
false
iex> !nil
true
```

## Variables
Variables in elixir are bound using the `=` operator.
```elixir
iex> x = 1
1
iex> x
1
```

Variable names must start with a lowercase letter. They can contain letters, numbers, and underscores.
```elixir
iex> x = 1
1
iex> x1 = 2
2
iex> x_1 = 3
3
```

Elixir uses snake_case for variable names.

## Functions

### Anonymous Functions

Anonymous functions are created using the `fn` keyword.
```elixir
iex> add = fn x, y -> x + y end
iex> add.(1, 2)
3
```

Here we are binding an anonymous function to the variable `add`. The function takes two arguments, `x` and `y`, and returns the sum of the two. The function is called using the `.` operator.

Functions in elixir are first class citizens. This means that they can be passed as arguments to other functions, returned from functions, and assigned to variables.

### Named Functions

Elixir provides many useful functions out of the box. These are called named functions. They are defined in modules. Modules are used to group related functions together.

Some built-in modules are `Kernel`, `IO`, `List`, `String`, `Integer`, and `Enum`.
| Module | Description | Example |
| ------ | ----------- | ------- |
| Kernel | Built-in functions | Kernel.is_number(1) |
| IO | Input/Output functions | IO.puts("Hello") |
| List | List functions | List.first([1, 2, 3]) |
| String | String functions | String.length("Hello") |
| Integer | Integer functions | Integer.is_even(2) |
| Enum | Enumerable functions | Enum.map([1, 2, 3], fn x -> x + 1 end) |


Named functions are created using the `def` keyword.
```elixir
defmodule Math do
  def add(x, y) do
    x + y
  end
end
```

Here we are creating a module named `Math`. The module contains a function named `add`. The function takes two arguments, `x` and `y`, and returns the sum of the two.

[lib/checkout.ex](./lib/checkout.ex)
```elixir
defmodule Checkout do
  def total_cost(price, tax_rate) do
    price * (1 + tax_rate)
  end
end
```

Here we have another module named `Checkout`. The module contains a function named `total_cost`. The function takes two arguments, `price` and `tax_rate`, and returns the total cost of an item.

You can execute the code in a module using the `iex` command.
```elixir
iex> c("checkout.ex")
[Checkout]
iex> Checkout.total_cost(10, 0.1)
11.0
```

In larger applications it is good practice to namespace your modules to prevent naming collisions.
[lib/ecommerce/checkout.ex](./lib/ecommerce/checkout.ex)
```elixir
defmodule Ecommerce.Checkout do
  def total_cost(price, tax_rate) do
    price * (1 + tax_rate)
  end
end
```

```elixir
iex> c("checkout.ex")
[Checkout]
iex> Ecommerce.Checkout.total_cost(10, 0.1)
11.0
```

### Importing Named Functions

You can call any named function using the pattern `Module.function_name`.

[/lib/task_list.ex](./lib/task_list.ex)
```elixir
defmodule TaskList do
  @file_name "task_list.txt"

  def add_task(task_name) do
    task = "[ ] " <> task_name <> "\n"
    File.write(@file_name, task, [:append])
  end

  def show_list do
    File.read(@file_name)
  end
end
```

This can get tedious when calling functions from the same module. You can import functions from a module using the `import` keyword.

[/lib/task_list_with_import.ex](./lib/task_list_with_import.ex)
```elixir
defmodule TaskListWithImport do
  import File, only: [write: 3, read: 1]

  @file_name "task_list.txt"

  def add_task(task_name) do
    task = "[ ] " <> task_name <> "\n"
    write(@file_name, task, [:append])
  end

  def show_list do
    read(@file_name)
  end
end
```