defmodule LottoAPI.OrderTransactionWithOrderEntriesTest do
  use LottoAPI.DataCase

  alias LottoAPI.{
    BatchOrderConfiguration,
    Order,
    OrderConfiguration,
    OrderEntry,
    OrderTransaction,
    OrderTransactionWithOrderEntries
  }

  describe "accumulate_order_entries/1" do
    test "returns a map of order_transaction and orders" do
      batch_order_config =
        Repo.insert!(%BatchOrderConfiguration{
          order_type: "up_two",
          period: ~D[2019-11-01]
        })

      Repo.insert!(%OrderConfiguration{
        limit: 100,
        order_num: "00",
        batch_order_configuration_id: batch_order_config.id
      })

      Repo.insert!(%OrderConfiguration{
        limit: 100,
        order_num: "01",
        batch_order_configuration_id: batch_order_config.id
      })

      Repo.insert!(%OrderConfiguration{
        limit: 100,
        order_num: "02",
        batch_order_configuration_id: batch_order_config.id
      })

      order_transaction =
        Repo.insert!(%OrderTransaction{
          order_type: "up_two",
          period: ~D[2019-11-01]
        })

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
        amount: 1,
        order_num: "02",
        order_transaction_id: order_transaction.id
      })

      Repo.insert!(%OrderEntry{
        amount: 102,
        order_num: "01",
        order_transaction_id: order_transaction.id
      })

      Repo.insert!(%OrderEntry{
        amount: 99,
        order_num: "02",
        order_transaction_id: order_transaction.id
      })

      result = OrderTransactionWithOrderEntries.accumulate_order_entries(order_transaction)

      assert result == %{
               order_transaction: order_transaction,
               orders: [
                 %Order{
                   order_num: "00",
                   limit: 100,
                   amount: 1,
                   remaining_amount: 99,
                   excess_amount: 0
                 },
                 %Order{
                   order_num: "01",
                   limit: 100,
                   amount: 100,
                   remaining_amount: 0,
                   excess_amount: 2
                 },
                 %Order{
                   order_num: "02",
                   limit: 100,
                   amount: 100,
                   remaining_amount: 0,
                   excess_amount: 0
                 }
               ]
             }
    end
  end
end
