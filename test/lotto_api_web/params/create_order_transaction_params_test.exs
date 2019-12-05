defmodule LottoAPIWeb.CreateOrderTransactionParamsTest do
  use LottoAPI.DataCase, async: true

  alias LottoAPIWeb.CreateOrderTransactionParams

  describe "changeset/1" do
    test "returns an invalid changeset if the given params is invalid" do
      params = %{"period" => "123", "order_type" => "up_one"}

      changeset = CreateOrderTransactionParams.changeset(params)

      refute changeset.valid?
      assert errors_on(changeset) == %{period: ["is invalid"], order_type: ["is invalid"]}
    end

    test "returns an invalid changeset if the given orders is invalid" do
      params = %{
        "period" => "2019-11-01",
        "order_type" => "up_two",
        "orders" => [
          %{"amount" => 10, "order_num" => "000"},
          %{}
        ]
      }

      changeset = CreateOrderTransactionParams.changeset(params)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               orders: [
                 %{order_num: ["is invalid"]},
                 %{amount: ["can't be blank"], order_num: ["can't be blank"]}
               ]
             }
    end

    test "returns a valid changeset if the given params is valid" do
      params = %{
        "period" => "2019-11-01",
        "order_type" => "up_two",
        "orders" => [
          %{"amount" => 10, "order_num" => "00"},
          %{"amount" => 20, "order_num" => "10"}
        ]
      }

      changeset = CreateOrderTransactionParams.changeset(params)

      assert changeset.valid?
    end

    test "sorts order_num when order_type is 'shuffle_three'" do
      params = %{
        "period" => "2019-11-01",
        "order_type" => "shuffle_three",
        "orders" => [
          %{"amount" => 10, "order_num" => "010"},
          %{"amount" => 10, "order_num" => "100"}
        ]
      }

      changeset = CreateOrderTransactionParams.changeset(params)

      assert changeset.valid?

      assert [
               %{
                 changes: %{order_num: "001"}
               },
               %{
                 changes: %{order_num: "001"}
               }
             ] = changeset.changes.orders
    end
  end
end
