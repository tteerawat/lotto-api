defmodule LottoAPIWeb.OrderConfigurationView do
  use LottoAPIWeb, :view

  def render("list.json", %{
        period: period,
        order_configurations: order_configurations,
        numbers: numbers
      }) do
    limits_map = Enum.into(order_configurations, %{}, &{&1.order_num, &1.limit})

    %{
      period: period,
      configs:
        Enum.map(numbers, fn number ->
          %{
            order_num: number,
            limit: Map.get(limits_map, number, 0)
          }
        end)
    }
  end

  def render("list.json", %{
        period: period,
        order_configurations: order_configurations
      }) do
    %{
      period: period,
      configs:
        Enum.map(order_configurations, fn config ->
          %{
            order_num: config.order_num,
            limit: config.limit
          }
        end)
    }
  end
end
