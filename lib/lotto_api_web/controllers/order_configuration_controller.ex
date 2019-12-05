defmodule LottoAPIWeb.OrderConfigurationController do
  use LottoAPIWeb, :controller

  alias LottoAPI.{Numbers, OrderConfigurations}

  plug :validate_params, with: LottoAPIWeb.ListOrderConfigurationsParams, action: :index
  plug :validate_params, with: LottoAPIWeb.CreateOrderConfigurationsParams, action: :create

  def index(%{assigns: %{validated_params: validated_params}} = conn, _) do
    %{period: period, order_type: order_type} = validated_params

    order_configurations =
      OrderConfigurations.list_order_configurations(period: period, order_type: order_type)

    numbers = Numbers.list_numbers_from_order_type(order_type)

    conn
    |> put_status(:ok)
    |> put_view(LottoAPIWeb.OrderConfigurationView)
    |> render("list.json",
      period: period,
      order_configurations: order_configurations,
      numbers: numbers
    )
  end

  def create(%{assigns: %{validated_params: %{period: period} = validated_params}} = conn, _) do
    order_configurations =
      validated_params
      |> to_create_params_list()
      |> OrderConfigurations.create_or_update_order_configurations()

    conn
    |> put_status(:created)
    |> put_view(LottoAPIWeb.OrderConfigurationView)
    |> render("list.json", period: period, order_configurations: order_configurations)
  end

  defp to_create_params_list(%{order_type: order_type} = params) do
    order_type
    |> Numbers.list_numbers_from_order_type()
    |> Enum.map(fn number -> Map.put(params, :order_num, number) end)
  end
end
