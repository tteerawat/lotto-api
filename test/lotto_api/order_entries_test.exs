defmodule LottoAPI.OrderEntriesTest do
  use LottoAPI.DataCase

  alias LottoAPI.{OrderEntries, OrderEntry, OrderTransaction}

  describe "create_order_entries!/1" do
    test "create order entries from the given params list" do
      order_transaction =
        Repo.insert!(%OrderTransaction{order_type: "up_two", period: ~D[2019-11-01]})

      params_list = [
        %{order_num: "00", amount: 10, order_transaction_id: order_transaction.id},
        %{order_num: "01", amount: 30, order_transaction_id: order_transaction.id}
      ]

      :ok = OrderEntries.create_order_entries!(params_list)

      assert Repo.aggregate(OrderEntry, :count, :id) == 2

      assert Repo.get_by(OrderEntry,
               order_num: "00",
               amount: 10,
               order_transaction_id: order_transaction.id
             )

      assert Repo.get_by(OrderEntry,
               order_num: "01",
               amount: 30,
               order_transaction_id: order_transaction.id
             )
    end
  end
end
