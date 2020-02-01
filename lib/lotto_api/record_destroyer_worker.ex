defmodule LottoAPI.RecordDestroyerWorker do
  use GenServer

  alias LottoAPI.RecordDestroyer

  @delay_on_start :timer.seconds(5)
  @interval :timer.hours(24)

  def start_link(time_amount) do
    GenServer.start_link(__MODULE__, time_amount, name: __MODULE__)
  end

  def init(time_amount) do
    schedule(@delay_on_start)
    {:ok, %{time_amount: time_amount}}
  end

  def handle_info(:trigger, %{time_amount: time_amount} = state) do
    RecordDestroyer.destroy(time_amount)
    schedule(@interval)
    {:noreply, state}
  end

  defp schedule(interval) do
    Process.send_after(self(), :trigger, interval)
  end
end
