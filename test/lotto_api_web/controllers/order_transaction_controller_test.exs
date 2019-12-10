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

    test "renders 200 ok response with default values if the order transaction cannot be found",
         %{conn: conn} do
      conn =
        get(conn, Routes.order_transaction_path(conn, :index), %{
          "order_type" => "up_two",
          "period" => "2019-11-01"
        })

      assert json_response(conn, 200) == %{
               "order_type" => "up_two",
               "orders" => [
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "00",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "01",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "02",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "03",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "04",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "05",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "06",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "07",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "08",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "09",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "10",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "11",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "12",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "13",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "14",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "15",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "16",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "17",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "18",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "19",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "20",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "21",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "22",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "23",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "24",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "25",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "26",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "27",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "28",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "29",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "30",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "31",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "32",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "33",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "34",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "35",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "36",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "37",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "38",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "39",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "40",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "41",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "42",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "43",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "44",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "45",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "46",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "47",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "48",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "49",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "50",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "51",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "52",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "53",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "54",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "55",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "56",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "57",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "58",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "59",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "60",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "61",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "62",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "63",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "64",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "65",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "66",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "67",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "68",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "69",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "70",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "71",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "72",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "73",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "74",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "75",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "76",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "77",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "78",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "79",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "80",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "81",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "82",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "83",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "84",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "85",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "86",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "87",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "88",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "89",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "90",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "91",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "92",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "93",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "94",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "95",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "96",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "97",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "98",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "99",
                   "remaining_amount" => 0
                 }
               ],
               "period" => "2019-11-01"
             }
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
               "order_type" => "up_two",
               "period" => "2019-11-01",
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
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "03",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "04",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "05",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "06",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "07",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "08",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "09",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "10",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "11",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "12",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "13",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "14",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "15",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "16",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "17",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "18",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "19",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "20",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "21",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "22",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "23",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "24",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "25",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "26",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "27",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "28",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "29",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "30",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "31",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "32",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "33",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "34",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "35",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "36",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "37",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "38",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "39",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "40",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "41",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "42",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "43",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "44",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "45",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "46",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "47",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "48",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "49",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "50",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "51",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "52",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "53",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "54",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "55",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "56",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "57",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "58",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "59",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "60",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "61",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "62",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "63",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "64",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "65",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "66",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "67",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "68",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "69",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "70",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "71",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "72",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "73",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "74",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "75",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "76",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "77",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "78",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "79",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "80",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "81",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "82",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "83",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "84",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "85",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "86",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "87",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "88",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "89",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "90",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "91",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "92",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "93",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "94",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "95",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "96",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "97",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "98",
                   "remaining_amount" => 0
                 },
                 %{
                   "amount" => 0,
                   "excess_amount" => 0,
                   "limit" => 0,
                   "order_num" => "99",
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
