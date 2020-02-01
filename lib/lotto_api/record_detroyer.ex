defmodule LottoAPI.RecordDestroyer do
  import Ecto.Query

  alias LottoAPI.{BatchOrderConfiguration, OrderTransaction, Repo}

  def destroy(time_amount_in_millisecond) do
    datetime =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.add(-time_amount_in_millisecond, :millisecond)

    Repo.transaction(fn ->
      delete_all_expired_records(BatchOrderConfiguration, datetime)
      delete_all_expired_records(OrderTransaction, datetime)
    end)
  end

  defp delete_all_expired_records(query, datetime) do
    query
    |> where([r], r.inserted_at < ^datetime)
    |> Repo.delete_all()
  end
end
