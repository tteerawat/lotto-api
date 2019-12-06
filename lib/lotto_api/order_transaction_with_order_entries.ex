defmodule LottoAPI.Order do
  defstruct [
    :order_num,
    :limit,
    :amount,
    :remaining_amount,
    :excess_amount
  ]
end

defmodule LottoAPI.OrderTransactionWithOrderEntries do
  alias LottoAPI.{BatchOrderConfigurations, Repo}

  def accumulate_order_entries(order_transaction) do
    {:ok, batch_order_config} =
      BatchOrderConfigurations.fetch_batch_order_configuration_by(
        order_type: order_transaction.order_type,
        period: order_transaction.period
      )

    limits_map =
      Enum.into(batch_order_config.order_configurations, %{}, &{&1.order_num, &1.limit})

    orders =
      order_transaction
      |> Repo.preload(:order_entries)
      |> Map.get(:order_entries)
      |> Enum.group_by(& &1.order_num, & &1.amount)
      |> Enum.map(fn {order_num, amounts} ->
        configured_limit = Map.fetch!(limits_map, order_num)
        total_amount = Enum.sum(amounts)

        cond do
          total_amount > configured_limit ->
            %LottoAPI.Order{
              order_num: order_num,
              limit: configured_limit,
              amount: configured_limit,
              remaining_amount: 0,
              excess_amount: total_amount - configured_limit
            }

          total_amount < configured_limit ->
            %LottoAPI.Order{
              order_num: order_num,
              limit: configured_limit,
              amount: total_amount,
              remaining_amount: configured_limit - total_amount,
              excess_amount: 0
            }

          total_amount == configured_limit ->
            %LottoAPI.Order{
              order_num: order_num,
              limit: configured_limit,
              amount: total_amount,
              remaining_amount: 0,
              excess_amount: 0
            }
        end
      end)

    %{
      order_transaction: order_transaction,
      orders: orders
    }
  end
end
