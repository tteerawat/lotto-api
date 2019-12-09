defmodule LottoAPIWeb.CreateTokenParams do
  use LottoAPIWeb, :params

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  def changeset(data \\ %__MODULE__{}, params) do
    data
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
  end
end
