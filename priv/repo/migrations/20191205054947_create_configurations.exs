defmodule LottoAPI.Repo.Migrations.CreateConfigurations do
  use Ecto.Migration

  def change do
    create table(:order_configurations) do
      add :order_type, :string, null: false
      add :period, :date, null: false
      add :order_num, :string, null: false
      add :limit, :integer, null: false

      timestamps()
    end

    create index(:order_configurations, [:period, :order_type])
    create index(:order_configurations, [:period, :order_type, :order_num], unique: true)
  end
end
