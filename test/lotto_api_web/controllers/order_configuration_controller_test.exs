defmodule LottoAPIWeb.OrderConfigurationControllerTest do
  use LottoAPIWeb.ConnCase

  alias LottoAPI.{BatchOrderConfiguration, OrderConfiguration}

  describe "index/2" do
    test "renders 400 error response if the given params is invalid", %{conn: conn} do
      conn = get(conn, Routes.order_configuration_path(conn, :index), %{})

      assert json_response(conn, 400) == %{
               "errors" => %{
                 "order_type" => ["can't be blank"],
                 "period" => ["can't be blank"]
               }
             }
    end

    test "renders 404 error response if the batch order config cannot be found", %{conn: conn} do
      conn =
        get(conn, Routes.order_configuration_path(conn, :index), %{
          "order_type" => "up_two",
          "period" => "2019-11-01"
        })

      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end

    test "renders 200 ok response if the given params is valid", %{conn: conn} do
      batch_order_configuration =
        Repo.insert!(%BatchOrderConfiguration{
          order_type: "up_two",
          period: ~D[2019-11-01]
        })

      Repo.insert!(%OrderConfiguration{
        order_num: "00",
        limit: 10,
        batch_order_configuration_id: batch_order_configuration.id
      })

      Repo.insert!(%OrderConfiguration{
        order_num: "01",
        limit: 20,
        batch_order_configuration_id: batch_order_configuration.id
      })

      conn =
        get(conn, Routes.order_configuration_path(conn, :index), %{
          "order_type" => "up_two",
          "period" => "2019-11-01"
        })

      assert json_response(conn, 200) == %{
               "configs" => [
                 %{"limit" => 10, "order_num" => "00"},
                 %{"limit" => 20, "order_num" => "01"}
               ],
               "period" => "2019-11-01"
             }
    end
  end

  describe "create/2" do
    test "renders 400 error response if the given params is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_configuration_path(conn, :create), %{})

      assert json_response(conn, 400) == %{
               "errors" => %{
                 "limit" => ["can't be blank"],
                 "order_type" => ["can't be blank"],
                 "period" => ["can't be blank"]
               }
             }
    end

    test "renders 201 created response if the given params is valid", %{conn: conn} do
      conn =
        post(conn, Routes.order_configuration_path(conn, :create), %{
          "order_type" => "shuffle_three",
          "limit" => 100,
          "period" => "2019-11-01"
        })

      assert Repo.one(BatchOrderConfiguration)
      assert Repo.aggregate(OrderConfiguration, :count, :id) == 220

      assert json_response(conn, 201) == %{
               "configs" => [
                 %{"limit" => 100, "order_num" => "000"},
                 %{"limit" => 100, "order_num" => "001"},
                 %{"limit" => 100, "order_num" => "002"},
                 %{"limit" => 100, "order_num" => "003"},
                 %{"limit" => 100, "order_num" => "004"},
                 %{"limit" => 100, "order_num" => "005"},
                 %{"limit" => 100, "order_num" => "006"},
                 %{"limit" => 100, "order_num" => "007"},
                 %{"limit" => 100, "order_num" => "008"},
                 %{"limit" => 100, "order_num" => "009"},
                 %{"limit" => 100, "order_num" => "011"},
                 %{"limit" => 100, "order_num" => "012"},
                 %{"limit" => 100, "order_num" => "013"},
                 %{"limit" => 100, "order_num" => "014"},
                 %{"limit" => 100, "order_num" => "015"},
                 %{"limit" => 100, "order_num" => "016"},
                 %{"limit" => 100, "order_num" => "017"},
                 %{"limit" => 100, "order_num" => "018"},
                 %{"limit" => 100, "order_num" => "019"},
                 %{"limit" => 100, "order_num" => "022"},
                 %{"limit" => 100, "order_num" => "023"},
                 %{"limit" => 100, "order_num" => "024"},
                 %{"limit" => 100, "order_num" => "025"},
                 %{"limit" => 100, "order_num" => "026"},
                 %{"limit" => 100, "order_num" => "027"},
                 %{"limit" => 100, "order_num" => "028"},
                 %{"limit" => 100, "order_num" => "029"},
                 %{"limit" => 100, "order_num" => "033"},
                 %{"limit" => 100, "order_num" => "034"},
                 %{"limit" => 100, "order_num" => "035"},
                 %{"limit" => 100, "order_num" => "036"},
                 %{"limit" => 100, "order_num" => "037"},
                 %{"limit" => 100, "order_num" => "038"},
                 %{"limit" => 100, "order_num" => "039"},
                 %{"limit" => 100, "order_num" => "044"},
                 %{"limit" => 100, "order_num" => "045"},
                 %{"limit" => 100, "order_num" => "046"},
                 %{"limit" => 100, "order_num" => "047"},
                 %{"limit" => 100, "order_num" => "048"},
                 %{"limit" => 100, "order_num" => "049"},
                 %{"limit" => 100, "order_num" => "055"},
                 %{"limit" => 100, "order_num" => "056"},
                 %{"limit" => 100, "order_num" => "057"},
                 %{"limit" => 100, "order_num" => "058"},
                 %{"limit" => 100, "order_num" => "059"},
                 %{"limit" => 100, "order_num" => "066"},
                 %{"limit" => 100, "order_num" => "067"},
                 %{"limit" => 100, "order_num" => "068"},
                 %{"limit" => 100, "order_num" => "069"},
                 %{"limit" => 100, "order_num" => "077"},
                 %{"limit" => 100, "order_num" => "078"},
                 %{"limit" => 100, "order_num" => "079"},
                 %{"limit" => 100, "order_num" => "088"},
                 %{"limit" => 100, "order_num" => "089"},
                 %{"limit" => 100, "order_num" => "099"},
                 %{"limit" => 100, "order_num" => "111"},
                 %{"limit" => 100, "order_num" => "112"},
                 %{"limit" => 100, "order_num" => "113"},
                 %{"limit" => 100, "order_num" => "114"},
                 %{"limit" => 100, "order_num" => "115"},
                 %{"limit" => 100, "order_num" => "116"},
                 %{"limit" => 100, "order_num" => "117"},
                 %{"limit" => 100, "order_num" => "118"},
                 %{"limit" => 100, "order_num" => "119"},
                 %{"limit" => 100, "order_num" => "122"},
                 %{"limit" => 100, "order_num" => "123"},
                 %{"limit" => 100, "order_num" => "124"},
                 %{"limit" => 100, "order_num" => "125"},
                 %{"limit" => 100, "order_num" => "126"},
                 %{"limit" => 100, "order_num" => "127"},
                 %{"limit" => 100, "order_num" => "128"},
                 %{"limit" => 100, "order_num" => "129"},
                 %{"limit" => 100, "order_num" => "133"},
                 %{"limit" => 100, "order_num" => "134"},
                 %{"limit" => 100, "order_num" => "135"},
                 %{"limit" => 100, "order_num" => "136"},
                 %{"limit" => 100, "order_num" => "137"},
                 %{"limit" => 100, "order_num" => "138"},
                 %{"limit" => 100, "order_num" => "139"},
                 %{"limit" => 100, "order_num" => "144"},
                 %{"limit" => 100, "order_num" => "145"},
                 %{"limit" => 100, "order_num" => "146"},
                 %{"limit" => 100, "order_num" => "147"},
                 %{"limit" => 100, "order_num" => "148"},
                 %{"limit" => 100, "order_num" => "149"},
                 %{"limit" => 100, "order_num" => "155"},
                 %{"limit" => 100, "order_num" => "156"},
                 %{"limit" => 100, "order_num" => "157"},
                 %{"limit" => 100, "order_num" => "158"},
                 %{"limit" => 100, "order_num" => "159"},
                 %{"limit" => 100, "order_num" => "166"},
                 %{"limit" => 100, "order_num" => "167"},
                 %{"limit" => 100, "order_num" => "168"},
                 %{"limit" => 100, "order_num" => "169"},
                 %{"limit" => 100, "order_num" => "177"},
                 %{"limit" => 100, "order_num" => "178"},
                 %{"limit" => 100, "order_num" => "179"},
                 %{"limit" => 100, "order_num" => "188"},
                 %{"limit" => 100, "order_num" => "189"},
                 %{"limit" => 100, "order_num" => "199"},
                 %{"limit" => 100, "order_num" => "222"},
                 %{"limit" => 100, "order_num" => "223"},
                 %{"limit" => 100, "order_num" => "224"},
                 %{"limit" => 100, "order_num" => "225"},
                 %{"limit" => 100, "order_num" => "226"},
                 %{"limit" => 100, "order_num" => "227"},
                 %{"limit" => 100, "order_num" => "228"},
                 %{"limit" => 100, "order_num" => "229"},
                 %{"limit" => 100, "order_num" => "233"},
                 %{"limit" => 100, "order_num" => "234"},
                 %{"limit" => 100, "order_num" => "235"},
                 %{"limit" => 100, "order_num" => "236"},
                 %{"limit" => 100, "order_num" => "237"},
                 %{"limit" => 100, "order_num" => "238"},
                 %{"limit" => 100, "order_num" => "239"},
                 %{"limit" => 100, "order_num" => "244"},
                 %{"limit" => 100, "order_num" => "245"},
                 %{"limit" => 100, "order_num" => "246"},
                 %{"limit" => 100, "order_num" => "247"},
                 %{"limit" => 100, "order_num" => "248"},
                 %{"limit" => 100, "order_num" => "249"},
                 %{"limit" => 100, "order_num" => "255"},
                 %{"limit" => 100, "order_num" => "256"},
                 %{"limit" => 100, "order_num" => "257"},
                 %{"limit" => 100, "order_num" => "258"},
                 %{"limit" => 100, "order_num" => "259"},
                 %{"limit" => 100, "order_num" => "266"},
                 %{"limit" => 100, "order_num" => "267"},
                 %{"limit" => 100, "order_num" => "268"},
                 %{"limit" => 100, "order_num" => "269"},
                 %{"limit" => 100, "order_num" => "277"},
                 %{"limit" => 100, "order_num" => "278"},
                 %{"limit" => 100, "order_num" => "279"},
                 %{"limit" => 100, "order_num" => "288"},
                 %{"limit" => 100, "order_num" => "289"},
                 %{"limit" => 100, "order_num" => "299"},
                 %{"limit" => 100, "order_num" => "333"},
                 %{"limit" => 100, "order_num" => "334"},
                 %{"limit" => 100, "order_num" => "335"},
                 %{"limit" => 100, "order_num" => "336"},
                 %{"limit" => 100, "order_num" => "337"},
                 %{"limit" => 100, "order_num" => "338"},
                 %{"limit" => 100, "order_num" => "339"},
                 %{"limit" => 100, "order_num" => "344"},
                 %{"limit" => 100, "order_num" => "345"},
                 %{"limit" => 100, "order_num" => "346"},
                 %{"limit" => 100, "order_num" => "347"},
                 %{"limit" => 100, "order_num" => "348"},
                 %{"limit" => 100, "order_num" => "349"},
                 %{"limit" => 100, "order_num" => "355"},
                 %{"limit" => 100, "order_num" => "356"},
                 %{"limit" => 100, "order_num" => "357"},
                 %{"limit" => 100, "order_num" => "358"},
                 %{"limit" => 100, "order_num" => "359"},
                 %{"limit" => 100, "order_num" => "366"},
                 %{"limit" => 100, "order_num" => "367"},
                 %{"limit" => 100, "order_num" => "368"},
                 %{"limit" => 100, "order_num" => "369"},
                 %{"limit" => 100, "order_num" => "377"},
                 %{"limit" => 100, "order_num" => "378"},
                 %{"limit" => 100, "order_num" => "379"},
                 %{"limit" => 100, "order_num" => "388"},
                 %{"limit" => 100, "order_num" => "389"},
                 %{"limit" => 100, "order_num" => "399"},
                 %{"limit" => 100, "order_num" => "444"},
                 %{"limit" => 100, "order_num" => "445"},
                 %{"limit" => 100, "order_num" => "446"},
                 %{"limit" => 100, "order_num" => "447"},
                 %{"limit" => 100, "order_num" => "448"},
                 %{"limit" => 100, "order_num" => "449"},
                 %{"limit" => 100, "order_num" => "455"},
                 %{"limit" => 100, "order_num" => "456"},
                 %{"limit" => 100, "order_num" => "457"},
                 %{"limit" => 100, "order_num" => "458"},
                 %{"limit" => 100, "order_num" => "459"},
                 %{"limit" => 100, "order_num" => "466"},
                 %{"limit" => 100, "order_num" => "467"},
                 %{"limit" => 100, "order_num" => "468"},
                 %{"limit" => 100, "order_num" => "469"},
                 %{"limit" => 100, "order_num" => "477"},
                 %{"limit" => 100, "order_num" => "478"},
                 %{"limit" => 100, "order_num" => "479"},
                 %{"limit" => 100, "order_num" => "488"},
                 %{"limit" => 100, "order_num" => "489"},
                 %{"limit" => 100, "order_num" => "499"},
                 %{"limit" => 100, "order_num" => "555"},
                 %{"limit" => 100, "order_num" => "556"},
                 %{"limit" => 100, "order_num" => "557"},
                 %{"limit" => 100, "order_num" => "558"},
                 %{"limit" => 100, "order_num" => "559"},
                 %{"limit" => 100, "order_num" => "566"},
                 %{"limit" => 100, "order_num" => "567"},
                 %{"limit" => 100, "order_num" => "568"},
                 %{"limit" => 100, "order_num" => "569"},
                 %{"limit" => 100, "order_num" => "577"},
                 %{"limit" => 100, "order_num" => "578"},
                 %{"limit" => 100, "order_num" => "579"},
                 %{"limit" => 100, "order_num" => "588"},
                 %{"limit" => 100, "order_num" => "589"},
                 %{"limit" => 100, "order_num" => "599"},
                 %{"limit" => 100, "order_num" => "666"},
                 %{"limit" => 100, "order_num" => "667"},
                 %{"limit" => 100, "order_num" => "668"},
                 %{"limit" => 100, "order_num" => "669"},
                 %{"limit" => 100, "order_num" => "677"},
                 %{"limit" => 100, "order_num" => "678"},
                 %{"limit" => 100, "order_num" => "679"},
                 %{"limit" => 100, "order_num" => "688"},
                 %{"limit" => 100, "order_num" => "689"},
                 %{"limit" => 100, "order_num" => "699"},
                 %{"limit" => 100, "order_num" => "777"},
                 %{"limit" => 100, "order_num" => "778"},
                 %{"limit" => 100, "order_num" => "779"},
                 %{"limit" => 100, "order_num" => "788"},
                 %{"limit" => 100, "order_num" => "789"},
                 %{"limit" => 100, "order_num" => "799"},
                 %{"limit" => 100, "order_num" => "888"},
                 %{"limit" => 100, "order_num" => "889"},
                 %{"limit" => 100, "order_num" => "899"},
                 %{"limit" => 100, "order_num" => "999"}
               ],
               "period" => "2019-11-01"
             }
    end
  end
end
