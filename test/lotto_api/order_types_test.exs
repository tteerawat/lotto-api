defmodule LottoAPI.OrderTypesTest do
  use LottoAPI.DataCase, async: true

  alias LottoAPI.OrderTypes

  describe "list_order_types/0" do
    test "returns a list of valid order types" do
      result = OrderTypes.list_order_types()

      assert result == ["up_two", "down_two", "up_three", "shuffle_three"]
    end
  end
end
