defmodule LottoAPI.Repo.Migrations.CreateOrderTransactions do
  use Ecto.Migration

  def change do
    create table(:order_transactions) do
      add :order_type, :string, null: false
      add :period, :date, null: false

      timestamps(updated_at: false)
    end

    create index(:order_transactions, [:period, :order_type], unique: true)
  end
end
