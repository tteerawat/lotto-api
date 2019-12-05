defmodule LottoAPI.OrderTransactionWithOrderEntries do
  alias LottoAPI.Repo

  def accumulate_order_entries(order_transaction) do
    order_entries =
      order_transaction
      |> Repo.preload(:order_entries)
      |> Map.get(:order_entries)
      |> Enum.group_by(& &1.order_num, & &1.amount)
      |> Enum.map(fn {order_num, amounts} ->
        %{
          order_num: order_num,
          amount: Enum.sum(amounts)
        }
      end)

    %{
      order_transaction: order_transaction,
      order_entries: order_entries
    }
  end
end
