defmodule LottoAPI.OrderConfigurationsTest do
  use LottoAPI.DataCase

  alias LottoAPI.{OrderConfiguration, OrderConfigurations}

  describe "create_or_update_order_configurations/1" do
    test "creates order configurations from the given params list" do
      params_list = [
        %{order_type: "up_two", order_num: "03", limit: 10, period: ~D[2019-11-01]}
      ]

      result = OrderConfigurations.create_or_update_order_configurations(params_list)

      assert [
               %OrderConfiguration{
                 order_type: "up_two",
                 order_num: "03",
                 limit: 10,
                 period: ~D[2019-11-01]
               }
             ] = result

      assert ^result = Repo.all(OrderConfiguration)
    end

    test "updates order configurations from the given params list" do
      Repo.insert!(%OrderConfiguration{
        order_type: "up_two",
        order_num: "03",
        limit: 10,
        period: ~D[2019-11-01]
      })

      params_list = [
        %{order_type: "up_two", order_num: "03", limit: 100, period: ~D[2019-11-01]}
      ]

      result = OrderConfigurations.create_or_update_order_configurations(params_list)

      assert [
               %OrderConfiguration{
                 order_type: "up_two",
                 order_num: "03",
                 limit: 100,
                 period: ~D[2019-11-01]
               }
             ] = result

      assert ^result = Repo.all(OrderConfiguration)
    end
  end
end
