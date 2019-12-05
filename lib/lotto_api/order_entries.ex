defmodule LottoAPI.OrderEntries do
  alias LottoAPI.{OrderEntry, Repo}

  def create_order_entries!(params_list) do
    fields_maps = Enum.map(params_list, &assign_timestamps/1)
    Repo.insert_all(OrderEntry, fields_maps)

    :ok
  end

  defp assign_timestamps(params) do
    time_now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    params
    |> Map.put(:inserted_at, time_now)
  end
end
