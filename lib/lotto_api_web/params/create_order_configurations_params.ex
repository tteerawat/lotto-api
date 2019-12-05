defmodule LottoAPIWeb.CreateOrderConfigurationsParams do
  use LottoAPIWeb, :params

  alias LottoAPI.OrderTypes

  embedded_schema do
    field :period, :date
    field :limit, :integer
    field :order_type, :string
  end

  def changeset(data \\ %__MODULE__{}, params) do
    data
    |> cast(params, [:period, :limit, :order_type])
    |> validate_required([:period, :limit, :order_type])
    |> validate_inclusion(:order_type, OrderTypes.list_order_types())
    |> validate_number(:limit, greater_than_or_equal_to: 0)
  end
end
