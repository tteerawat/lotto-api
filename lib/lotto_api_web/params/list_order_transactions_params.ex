defmodule LottoAPIWeb.ListOrderTransactionsParams do
  use LottoAPIWeb, :params

  alias LottoAPI.OrderTypes

  embedded_schema do
    field :period, :date
    field :order_type, :string
  end

  def changeset(data \\ %__MODULE__{}, params) do
    data
    |> cast(params, [:period, :order_type])
    |> validate_required([:period, :order_type])
    |> validate_inclusion(:order_type, OrderTypes.list_order_types())
  end
end
