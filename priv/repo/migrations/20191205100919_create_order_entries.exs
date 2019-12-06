defmodule LottoAPI.Repo.Migrations.CreateOrderEntries do
  use Ecto.Migration

  def change do
    create table(:order_entries) do
      add :order_num, :string, null: false
      add :amount, :integer, null: false

      add :order_transaction_id, references(:order_transactions, on_delete: :delete_all),
        null: false

      timestamps(updated_at: false)
    end

    create index(:order_entries, [:order_transaction_id])
  end
end
