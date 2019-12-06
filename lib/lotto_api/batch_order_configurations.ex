defmodule LottoAPI.BatchOrderConfigurations do
  alias LottoAPI.{BatchOrderConfiguration, Numbers, OrderConfigurations, Repo}

  def fetch_batch_order_configuration_by(params) do
    case Repo.get_by(BatchOrderConfiguration, params) do
      nil ->
        {:error, :not_found}

      batch_order_configuration ->
        {:ok, preload_order_configurations(batch_order_configuration)}
    end
  end

  def create_batch_order_configuration_and_order_configurations!(period, order_type, limit) do
    {:ok, batch_order_configuration} =
      Repo.transaction(fn ->
        batch_order_configuration =
          get_or_create_batch_order_configuration!(%{
            period: period,
            order_type: order_type
          })

        batch_order_configuration
        |> build_create_or_update_order_configurations_params(order_type, limit)
        |> OrderConfigurations.create_or_update_order_configurations!()

        batch_order_configuration
      end)

    preload_order_configurations(batch_order_configuration)
  end

  defp build_create_or_update_order_configurations_params(
         batch_order_configuration,
         order_type,
         limit
       ) do
    order_type
    |> Numbers.list_numbers_from_order_type()
    |> Enum.map(fn number ->
      %{
        limit: limit,
        order_num: number,
        batch_order_configuration_id: batch_order_configuration.id
      }
    end)
  end

  defp get_or_create_batch_order_configuration!(params) do
    case Repo.get_by(BatchOrderConfiguration, params) do
      nil ->
        BatchOrderConfiguration
        |> struct(params)
        |> Repo.insert!()

      batch_order_configuration ->
        batch_order_configuration
    end
  end

  defp preload_order_configurations(batch_order_configuration) do
    Repo.preload(batch_order_configuration, :order_configurations)
  end
end
