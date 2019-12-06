defmodule LottoAPIWeb.OrderTransactionControllerTest do
  use LottoAPIWeb.ConnCase

  alias LottoAPI.{
    BatchOrderConfiguration,
    OrderConfiguration,
    OrderEntry,
    OrderTransaction
  }

  describe "index/2" do
    test "renders 400 error response if the given params is invalid", %{conn: conn} do
      conn = get(conn, Routes.order_transaction_path(conn, :index), %{})

      assert json_response(conn, 400) == %{
               "errors" => %{
                 "order_type" => ["can't be blank"],
                 "period" => ["can't be blank"]
               }
             }
    end

    test "renders 404 error response if the order transaction cannot be found", %{conn: conn} do
      conn =
        get(conn, Routes.order_transaction_path(conn, :index), %{
          "order_type" => "up_two",
          "period" => "2019-11-01"
        })

      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "renders 200 ok response if the given params is valid", %{conn: conn} do
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

      conn =
        get(conn, Routes.order_transaction_path(conn, :index), %{
          "order_type" => "up_two",
          "period" => "2019-11-01"
        })

      assert json_response(conn, 200) == %{
               "period" => "2019-11-01",
               "order_type" => "up_two",
               "orders" => [
                 %{
                   "amount" => 1,
                   "excess_amount" => 0,
                   "limit" => 100,
                   "order_num" => "00",
                   "remaining_amount" => 99
                 },
                 %{
                   "amount" => 100,
                   "excess_amount" => 2,
                   "limit" => 100,
                   "order_num" => "01",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 100,
                   "excess_amount" => 0,
                   "limit" => 100,
                   "order_num" => "02",
                   "remaining_amount" => 0
                 }
               ]
             }
    end
  end

  describe "create/2" do
    test "renders 400 error response if the given params is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_transaction_path(conn, :create), %{})

      assert json_response(conn, 400) == %{
               "errors" => %{"order_type" => ["can't be blank"], "period" => ["can't be blank"]}
             }
    end

    test "renders 400 error response if there is no order configuration of the given order_type and period",
         %{conn: conn} do
      conn =
        post(conn, Routes.order_transaction_path(conn, :create), %{
          "order_type" => "up_three",
          "period" => "2019-11-01",
          "orders" => [%{"order_num" => "123", "amount" => 10}]
        })

      assert json_response(conn, 400) == %{
               "errors" => %{
                 "detail" => "up_three configuration of 2019-11-01 should be created first!"
               }
             }
    end

    test "renders 204 no_content response if the given params is valid and order config is already created",
         %{conn: conn} do
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

      conn =
        post(conn, Routes.order_transaction_path(conn, :create), %{
          "order_type" => "up_two",
          "period" => "2019-11-01",
          "orders" => [%{"order_num" => "00", "amount" => 10}]
        })

      assert json_response(conn, 204) == %{}
      assert Repo.one(OrderTransaction)
    end
  end
end
