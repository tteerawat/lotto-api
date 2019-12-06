defmodule LottoAPI.OrderConfiguration do
  use Ecto.Schema

  alias LottoAPI.BatchOrderConfiguration

  schema "order_configurations" do
    field :limit, :integer
    field :order_num, :string

    belongs_to :batch_order_configuration, BatchOrderConfiguration

    timestamps()
  end
end
