defmodule LottoAPI.OrderEntry do
  use Ecto.Schema

  alias LottoAPI.OrderTransaction

  schema "order_entries" do
    field :order_num, :string
    field :amount, :integer

    belongs_to :order_transaction, OrderTransaction

    timestamps(updated_at: false)
  end
end
