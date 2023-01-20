defmodule Checkout do
  def total_cost(price, tax_rate) when price >= 0 and tax_rate >= 0 do
    price * (1 + tax_rate)
  end
end
