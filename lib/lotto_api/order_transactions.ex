defmodule LottoAPI.OrderTransactions do
  alias LottoAPI.{OrderEntries, OrderTransaction, Repo}

  def fetch_order_transaction_by(params) do
    case Repo.get_by(OrderTransaction, params) do
      nil ->
        {:error, :not_found}

      order_transaction ->
        {:ok, order_transaction}
    end
  end

  def create_order_transaction_and_entries!(period, order_type, orders) do
    {:ok, order_transaction} =
      Repo.transaction(fn ->
        order_transaction =
          get_or_create_order_transaction!(%{
            period: period,
            order_type: order_type
          })

        order_transaction
        |> build_create_order_entries_params(orders)
        |> OrderEntries.create_order_entries!()

        order_transaction
      end)

    order_transaction
  end

  defp get_or_create_order_transaction!(params) do
    case Repo.get_by(OrderTransaction, params) do
      nil ->
        OrderTransaction
        |> struct(params)
        |> Repo.insert!()

      order_transaction ->
        order_transaction
    end
  end

  defp build_create_order_entries_params(order_transaction, orders) do
    Enum.map(orders, fn order ->
      %{
        order_transaction_id: order_transaction.id,
        amount: order.amount,
        order_num: order.order_num
      }
    end)
  end
end
