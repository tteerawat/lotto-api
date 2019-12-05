defmodule LottoAPI.OrderConfigurations do
  alias LottoAPI.{OrderConfiguration, Repo}

  def create_or_update_order_configurations(params_list) do
    fields_maps = Enum.map(params_list, &assign_timestamps/1)

    {_, configs} =
      Repo.insert_all(OrderConfiguration, fields_maps,
        returning: true,
        on_conflict: {:replace, [:limit, :updated_at]},
        conflict_target: [:period, :order_type, :order_num]
      )

    configs
  end

  defp assign_timestamps(params) do
    time_now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    params
    |> Map.put(:inserted_at, time_now)
    |> Map.put(:updated_at, time_now)
  end
end
