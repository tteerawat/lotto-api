defmodule LottoAPI.OrderTransaction do
  use Ecto.Schema

  alias LottoAPI.OrderEntry

  schema "order_transactions" do
    field :order_type, :string
    field :period, :date

    has_many :order_entries, OrderEntry

    timestamps(updated_at: false)
  end
end
