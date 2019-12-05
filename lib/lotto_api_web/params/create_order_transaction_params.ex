defmodule LottoAPIWeb.CreateOrderTransactionParams do
  use LottoAPIWeb, :params

  alias LottoAPI.{Numbers, OrderTypes}

  embedded_schema do
    field :period, :date
    field :order_type, :string

    embeds_many :orders, CreateOrderParams do
      field :order_num, :string
      field :amount, :integer
    end
  end

  def changeset(data \\ %__MODULE__{}, params) do
    data
    |> cast(params, [:period, :order_type])
    |> validate_required([:period, :order_type])
    |> validate_inclusion(:order_type, OrderTypes.list_order_types())
    |> validate_orders()
  end

  defp validate_orders(%{valid?: true, changes: %{order_type: order_type}} = changeset) do
    cast_embed(changeset, :orders,
      with: {__MODULE__, :create_order_changeset, [order_type]},
      required: true
    )
  end

  defp validate_orders(changeset) do
    changeset
  end

  def create_order_changeset(data, params, order_type) do
    data
    |> cast(params, [:order_num, :amount])
    |> validate_required([:order_num, :amount])
    |> update_shuffle_three_order_number(order_type)
    |> validate_inclusion(:order_num, Numbers.list_numbers_from_order_type(order_type))
  end

  defp update_shuffle_three_order_number(%{valid?: true} = changeset, "shuffle_three") do
    update_change(changeset, :order_num, &LottoAPI.Numbers.Helpers.sort_number/1)
  end

  defp update_shuffle_three_order_number(changeset, _) do
    changeset
  end
end
