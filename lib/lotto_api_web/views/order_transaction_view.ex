defmodule LottoAPIWeb.OrderTransactionView do
  use LottoAPIWeb, :view

  def render("list.json", %{order_type: order_type, period: period, orders: orders}) do
    %{
      period: period,
      order_type: order_type,
      orders:
        Enum.map(orders, fn order ->
          %{
            order_num: order.order_num,
            amount: order.amount,
            limit: order.limit,
            remaining_amount: order.remaining_amount,
            excess_amount: order.excess_amount
          }
        end)
    }
  end
end
