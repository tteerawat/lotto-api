defmodule LottoAPI.OrderTransactionsTest do
  use LottoAPI.DataCase

  alias LottoAPI.{OrderEntry, OrderTransaction, OrderTransactions}

  describe "create_order_transaction_and_entries!/1" do
    test "create order transaction and its order entries" do
      period = ~D[2019-11-01]
      order_type = "up_two"

      orders = [
        %{order_num: "00", amount: 100},
        %{order_num: "01", amount: 200}
      ]

      result = OrderTransactions.create_order_transaction_and_entries!(period, order_type, orders)

      assert %OrderTransaction{id: id} = result
      assert Repo.get(OrderTransaction, id) == result
      assert Repo.aggregate(OrderEntry, :count, :id) == 2
      assert Repo.get_by(OrderEntry, order_num: "00", order_transaction_id: id)
      assert Repo.get_by(OrderEntry, order_num: "01", order_transaction_id: id)
    end
  end
end
