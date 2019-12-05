defmodule LottoAPIWeb.CreateOrderConfigurationsParamsTest do
  use LottoAPI.DataCase, async: true

  alias LottoAPIWeb.CreateOrderConfigurationsParams

  describe "changeset/1" do
    test "returns an invalid changeset if the given params is invalid" do
      params = %{"period" => "123", "order_type" => "up_one"}

      changeset = CreateOrderConfigurationsParams.changeset(params)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               limit: ["can't be blank"],
               period: ["is invalid"],
               order_type: ["is invalid"]
             }
    end

    test "returns a valid changeset if the given params is valid" do
      params = %{"period" => "2019-11-11", "limit" => 1000, "order_type" => "up_two"}

      changeset = CreateOrderConfigurationsParams.changeset(params)

      assert changeset.valid?
    end
  end
end
