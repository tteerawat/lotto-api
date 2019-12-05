defmodule LottoAPI.OrderTypes do
  @order_types ~w[
    up_two
    down_two
    up_three
    shuffle_three
  ]

  def list_order_types do
    @order_types
  end
end
