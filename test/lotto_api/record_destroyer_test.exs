defmodule LottoAPI.RecordDestroyerTest do
  use LottoAPI.DataCase

  alias LottoAPI.{
    BatchOrderConfiguration,
    OrderConfiguration,
    OrderEntry,
    OrderTransaction,
    RecordDestroyer
  }

  describe "destroy/1" do
    test "destroys records from the given time amount" do
      datetime_at_4_minutes_ago =
        NaiveDateTime.utc_now()
        |> NaiveDateTime.truncate(:second)
        |> NaiveDateTime.add(-:timer.minutes(4), :millisecond)

      datetime_at_2_minutes_ago =
        NaiveDateTime.utc_now()
        |> NaiveDateTime.truncate(:second)
        |> NaiveDateTime.add(-:timer.minutes(2), :millisecond)

      batch_order_config1 =
        Repo.insert!(%BatchOrderConfiguration{
          order_type: "up_two",
          period: ~D[2019-11-01],
          inserted_at: datetime_at_4_minutes_ago
        })

      batch_order_config2 =
        Repo.insert!(%BatchOrderConfiguration{
          order_type: "up_two",
          period: ~D[2019-11-02],
          inserted_at: datetime_at_2_minutes_ago
        })

      order_config1 =
        Repo.insert!(%OrderConfiguration{
          order_num: "00",
          limit: 10,
          batch_order_configuration_id: batch_order_config1.id
        })

      order_config2 =
        Repo.insert!(%OrderConfiguration{
          order_num: "01",
          limit: 20,
          batch_order_configuration_id: batch_order_config2.id
        })

      order_transaction1 =
        Repo.insert!(%OrderTransaction{
          order_type: "up_two",
          period: ~D[2019-11-01],
          inserted_at: datetime_at_4_minutes_ago
        })

      order_transaction2 =
        Repo.insert!(%OrderTransaction{
          order_type: "up_two",
          period: ~D[2019-11-02],
          inserted_at: datetime_at_2_minutes_ago
        })

      order_entry1 =
        Repo.insert!(%OrderEntry{
          amount: 2,
          order_num: "00",
          order_transaction_id: order_transaction1.id
        })

      order_entry2 =
        Repo.insert!(%OrderEntry{
          amount: 3,
          order_num: "00",
          order_transaction_id: order_transaction2.id
        })

      RecordDestroyer.destroy(:timer.minutes(3))

      refute Repo.get(BatchOrderConfiguration, batch_order_config1.id)
      refute Repo.get(OrderConfiguration, order_config1.id)
      assert Repo.get(BatchOrderConfiguration, batch_order_config2.id)
      assert Repo.get(OrderConfiguration, order_config2.id)
      refute Repo.get(OrderTransaction, order_transaction1.id)
      refute Repo.get(OrderEntry, order_entry1.id)
      assert Repo.get(OrderTransaction, order_transaction2.id)
      assert Repo.get(OrderEntry, order_entry2.id)
    end
  end
end
