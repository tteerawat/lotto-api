defmodule LottoAPI.BatchOrderConfiguration do
  use Ecto.Schema

  alias LottoAPI.OrderConfiguration

  schema "batch_order_configurations" do
    field :order_type, :string
    field :period, :date

    has_many :order_configurations, OrderConfiguration

    timestamps()
  end
end
