defmodule LottoAPIWeb.OrderConfigurationView do
  use LottoAPIWeb, :view

  def render("list.json", %{period: period, order_configurations: order_configurations}) do
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
