defmodule LottoAPIWeb.ListOrderTransactionsParamsTest do
  use LottoAPI.DataCase, async: true

  alias LottoAPIWeb.ListOrderTransactionsParams

  describe "changeset/1" do
    test "returns an invalid changeset if the given params is invalid" do
      params = %{"order_type" => "up_one"}

      changeset = ListOrderTransactionsParams.changeset(params)

      refute changeset.valid?
      assert errors_on(changeset) == %{order_type: ["is invalid"], period: ["can't be blank"]}
    end

    test "returns a valid changeset if the given params is valid" do
      params = %{"period" => "2019-11-11", "order_type" => "up_two"}

      changeset = ListOrderTransactionsParams.changeset(params)

      assert changeset.valid?
    end
  end
end
