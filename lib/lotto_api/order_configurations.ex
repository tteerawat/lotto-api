defmodule LottoAPI.OrderConfigurations do
  alias LottoAPI.{OrderConfiguration, Repo}

  def create_or_update_order_configurations!(params_list) do
    fields_maps = Enum.map(params_list, &assign_timestamps/1)

    Repo.insert_all(OrderConfiguration, fields_maps,
      on_conflict: {:replace, [:limit, :updated_at]},
      conflict_target: [:batch_order_configuration_id, :order_num]
    )

    :ok
  end

  defp assign_timestamps(params) do
    time_now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    params
    |> Map.put(:inserted_at, time_now)
    |> Map.put(:updated_at, time_now)
  end
end
