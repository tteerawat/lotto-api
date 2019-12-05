defmodule LottoAPI.OrderConfiguration do
  use Ecto.Schema

  schema "order_configurations" do
    field :limit, :integer
    field :order_num, :string
    field :order_type, :string
    field :period, :date

    timestamps()
  end
end
