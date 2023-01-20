
# Recursion

### Bounded Recursion

Bounded recursion is when the recursion is bounded by a condition that will stop the recursion.

```elixir
defmodule Sum do
  def up_to(0), do: 0
  def up_to(n), do: n + up_to(n - 1)
end
```

```elixir
iex> Sum.up_to(5)
15
```

Breakdown: 
```
up_to(5)
= 5 + up_to(4)
= 5 + 4 + up_to(3)
= 5 + 4 + 3 + up_to(2)
= 5 + 4 + 3 + 2 + up_to(1)
= 5 + 4 + 3 + 2 + 1 + up_to(0) =5+4+3+2+1+0
= 15
```

### Iterating through a List

[head | tail] is a pattern matching operator that matches the head of a list to head and the tail of a list to tail. We can use this to iterate through a list.

[/lib/math](./lib/math.exs)
```elixir
defmodule Math do
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)
end
```

```elixir
iex> Math.sum([1, 2, 3])
6
iex> Math.sum([])
0
```

Breakdown:
```
sum([1, 2, 3])
= 1 + sum([2, 3])
= 1 + 2 + sum([3])
= 1 + 2 + 3 + sum([])
= 1 + 2 + 3 + 0
= 6
```

[/lib/enchanter_shop.ex](./lib/enchanter_shop.ex)
```elixir
defmodule EnchanterShop do
  @enchanter_name "Edwin"

  def test_data do
    [
      %{title: "Longsword", price: 50, magic: false},
      %{title: "Healing Potion", price: 60, magic: true},
      %{title: "Rope", price: 10, magic: false},
      %{title: "Dragon's Spear", price: 100, magic: true}
    ]
  end

  def enchant_for_sale([]), do: []

  def enchant_for_sale([item | incoming_items]) do
    new_item = %{
      title: "#{@enchanter_name}'s #{item.title}",
      price: item.price * 3,
      magic: true
    }

    [new_item | enchant_for_sale(incoming_items)]
  end
end
```

Here we have a function `enchant_for_sale` that takes a list of items and returns a list of enchanted items. The function uses pattern matching to match the head of the list to `item` and the tail of the list to `incoming_items`. The function then creates a new item with the title, price, and magic attributes. The price is tripled and the title is prefixed with the enchanter's name. The function then calls itself with the `incoming_items` and prepends the new item to the list.

```elixir
iex> EnchanterShop.enchant_for_sale(EnchanterShop.test_data)
[
  %{magic: true, price: 150, title: "Edwin's Longsword"},
  %{magic: true, price: 180, title: "Edwin's Healing Potion"},
  %{magic: true, price: 30, title: "Edwin's Rope"},
  %{magic: true, price: 300, title: "Edwin's Dragon's Spear"}
]
```