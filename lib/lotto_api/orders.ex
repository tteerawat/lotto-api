defmodule LottoAPI.Order do
  defstruct [
    :order_num,
    :limit,
    :amount,
    :remaining_amount,
    :excess_amount
  ]
end

defmodule LottoAPI.Orders do
  alias LottoAPI.{BatchOrderConfigurations, Numbers, OrderTransactions}

  def accumulate_order_entries(order_type, period) do
    configs = list_order_configs(order_type, period)
    order_entries = list_order_entries(order_type, period)
    limits_by_number = Enum.into(configs, %{}, &{&1.order_num, &1.limit})

    amounts_by_number =
      order_entries
      |> Enum.group_by(& &1.order_num, & &1.amount)
      |> Enum.map(fn {order_num, amounts} -> {order_num, Enum.sum(amounts)} end)
      |> Map.new()

    order_type
    |> Numbers.list_numbers_from_order_type()
    |> Enum.map(fn number ->
      configured_limit = Map.get(limits_by_number, number, 0)
      total_amount = Map.get(amounts_by_number, number, 0)

      cond do
        total_amount > configured_limit ->
          %LottoAPI.Order{
            order_num: number,
            limit: configured_limit,
            amount: configured_limit,
            remaining_amount: 0,
            excess_amount: total_amount - configured_limit
          }

        total_amount < configured_limit ->
          %LottoAPI.Order{
            order_num: number,
            limit: configured_limit,
            amount: total_amount,
            remaining_amount: configured_limit - total_amount,
            excess_amount: 0
          }

        total_amount == configured_limit ->
          %LottoAPI.Order{
            order_num: number,
            limit: configured_limit,
            amount: total_amount,
            remaining_amount: 0,
            excess_amount: 0
          }
      end
    end)
  end

  defp list_order_configs(order_type, period) do
    case BatchOrderConfigurations.fetch_batch_order_configuration_by(
           order_type: order_type,
           period: period
         ) do
      {:ok, batch_order_config} ->
        batch_order_config.order_configurations

      {:error, :not_found} ->
        []
    end
  end

  defp list_order_entries(order_type, period) do
    case OrderTransactions.fetch_order_transaction_by(
           order_type: order_type,
           period: period
         ) do
      {:ok, order_transaction} ->
        order_transaction.order_entries

      {:error, :not_found} ->
        []
    end
  end
end
