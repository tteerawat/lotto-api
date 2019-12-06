defmodule LottoAPI.Repo.Migrations.CreateBatchOrderConfigurations do
  use Ecto.Migration

  def change do
    create table(:batch_order_configurations) do
      add :order_type, :string, null: false
      add :period, :date, null: false

      timestamps()
    end

    create index(:batch_order_configurations, [:period, :order_type], unique: true)
  end
end
