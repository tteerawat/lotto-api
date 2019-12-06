defmodule LottoAPIWeb.OrderConfigurationController do
  use LottoAPIWeb, :controller

  alias LottoAPI.BatchOrderConfigurations

  plug :validate_params, with: LottoAPIWeb.ListOrderConfigurationsParams, action: :index
  plug :validate_params, with: LottoAPIWeb.CreateOrderConfigurationsParams, action: :create

  def index(conn, _) do
    %{period: period, order_type: order_type} = conn.assigns.validated_params

    case BatchOrderConfigurations.fetch_batch_order_configuration_by(
           period: period,
           order_type: order_type
         ) do
      {:ok, batch_order_configuration} ->
        conn
        |> put_status(:ok)
        |> put_view(LottoAPIWeb.OrderConfigurationView)
        |> render("list.json",
          period: period,
          order_configurations: batch_order_configuration.order_configurations
        )

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> put_view(LottoAPIWeb.ErrorView)
        |> render("404.json")
    end
  end

  def create(conn, _) do
    %{period: period, order_type: order_type, limit: limit} = conn.assigns.validated_params

    batch_order_configuration =
      BatchOrderConfigurations.create_batch_order_configuration_and_order_configurations!(
        period,
        order_type,
        limit
      )

    conn
    |> put_status(:created)
    |> put_view(LottoAPIWeb.OrderConfigurationView)
    |> render("list.json",
      period: period,
      order_configurations: batch_order_configuration.order_configurations
    )
  end
end
