defmodule LottoAPI.RecordDestroyer do
  import Ecto.Query

  alias LottoAPI.{BatchOrderConfiguration, OrderTransaction, Repo}

  def destroy(time_amount_in_millisecond) do
    datetime =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.add(-time_amount_in_millisecond, :millisecond)

    Repo.transaction(fn ->
      BatchOrderConfiguration
      |> where([b], b.inserted_at < ^datetime)
      |> Repo.delete_all()

      OrderTransaction
      |> where([b], b.inserted_at < ^datetime)
      |> Repo.delete_all()
    end)
  end
end

# defmodule LottoAPI.RecordDestroyer do
#   use GenServer
#
#   @interval :timer.hours(24)
#
#   def start_link() do
#     GenServer.start_link(__MODULE__, [], name: __MODULE__)
#   end
#
#   def init(_) do
#     {:ok, []}
#   end
#
#   def handle_info(:trigger, state) do
#   end
#
#   defp schedule(interval) do
#     Process.send_after(self(), :trigger, interval)
#   end
# end
