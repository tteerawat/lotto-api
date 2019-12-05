defmodule LottoAPI.OrderTransactionWithOrderEntriesTest do
  use LottoAPI.DataCase

  alias LottoAPI.{OrderEntry, OrderTransaction, OrderTransactionWithOrderEntries}

  describe "accumulate_order_entries/1" do
    test "returns a map of order_transaction and accumulated order_entries" do
      order_transaction =
        Repo.insert!(%OrderTransaction{order_type: "up_two", period: ~D[2019-11-01]})

      Repo.insert!(%OrderEntry{
        amount: 2,
        order_num: "00",
        order_transaction_id: order_transaction.id
      })

      Repo.insert!(%OrderEntry{
        amount: -1,
        order_num: "00",
        order_transaction_id: order_transaction.id
      })

      Repo.insert!(%OrderEntry{
        amount: 10,
        order_num: "01",
        order_transaction_id: order_transaction.id
      })

      result = OrderTransactionWithOrderEntries.accumulate_order_entries(order_transaction)

      assert result == %{
               order_transaction: order_transaction,
               order_entries: [
                 %{order_num: "00", amount: 1},
                 %{order_num: "01", amount: 10}
               ]
             }
    end
  end
end
