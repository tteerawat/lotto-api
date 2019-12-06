defmodule LottoAPI.Repo.Migrations.AddBatchOrderConfigurationIdToOrderConfigurations do
  use Ecto.Migration

  def change do
    alter table("order_configurations") do
      add :batch_order_configuration_id,
          references(:batch_order_configurations, on_delete: :delete_all),
          null: false

      remove :order_type, :string
      remove :period, :date
    end

    create index(:order_configurations, [:batch_order_configuration_id])
    create index(:order_configurations, [:batch_order_configuration_id, :order_num], unique: true)
  end
end
