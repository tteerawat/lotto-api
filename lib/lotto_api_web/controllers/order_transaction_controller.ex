defmodule LottoAPIWeb.OrderTransactionController do
  use LottoAPIWeb, :controller

  alias LottoAPI.{
    BatchOrderConfigurations,
    OrderTransactions,
    Orders
  }

  plug :validate_params, with: LottoAPIWeb.ListOrderTransactionsParams, action: :index
  plug :validate_params, with: LottoAPIWeb.CreateOrderTransactionParams, action: :create

  def index(conn, _) do
    %{period: period, order_type: order_type} = conn.assigns.validated_params
    orders = Orders.accumulate_order_entries(order_type, period)

    conn
    |> put_status(:ok)
    |> put_view(LottoAPIWeb.OrderTransactionView)
    |> render("list.json", period: period, order_type: order_type, orders: orders)
  end

  def create(conn, _) do
    %{period: period, order_type: order_type, orders: orders} = conn.assigns.validated_params

    case BatchOrderConfigurations.fetch_batch_order_configuration_by(
           period: period,
           order_type: order_type
         ) do
      {:ok, _} ->
        OrderTransactions.create_order_transaction_and_entries!(period, order_type, orders)

        conn
        |> put_status(:no_content)
        |> json(%{})

      {:error, :not_found} ->
        conn
        |> put_status(:bad_request)
        |> put_view(LottoAPIWeb.ErrorView)
        |> render("error.json",
          message: "#{order_type} configuration of #{period} should be created first!"
        )
    end
  end
end
