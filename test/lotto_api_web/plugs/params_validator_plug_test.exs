defmodule LottoAPIWeb.ParamsValidatorPlugTest do
  use LottoAPIWeb.ConnCase

  alias LottoAPIWeb.ParamsValidatorPlug

  defmodule TestParams do
    use LottoAPIWeb, :params

    embedded_schema do
      field :date, :date
      field :number, :integer
    end

    def changeset(data \\ %__MODULE__{}, params) do
      data
      |> cast(params, [:date, :number])
      |> validate_required([:date, :number])
    end
  end

  describe "validate_params/2 when phoenix_action is equal to the given action" do
    test "assigns :validated_params to the given conn if the given params is valid", %{conn: conn} do
      new_conn =
        conn
        |> put_private(:phoenix_action, :create)
        |> Map.put(:params, %{"date" => "2019-11-11", "number" => 100})
        |> ParamsValidatorPlug.validate_params(with: TestParams, action: :create)

      refute new_conn.halted
      assert new_conn.assigns[:validated_params] == %{date: ~D[2019-11-11], number: 100}
    end

    test "renders error view with 400 status code if the given params is invalid", %{conn: conn} do
      new_conn =
        conn
        |> put_private(:phoenix_action, :create)
        |> Map.put(:params, %{"date" => "11-11-2019"})
        |> ParamsValidatorPlug.validate_params(with: TestParams, action: :create)

      assert new_conn.halted

      assert json_response(new_conn, 400) == %{
               "errors" => %{
                 "date" => ["is invalid"],
                 "number" => ["can't be blank"]
               }
             }
    end
  end

  describe "validate_params/2 when phoenix_action is not equal to the given action" do
    test "returns the given conn without validating", %{
      conn: conn
    } do
      new_conn =
        conn
        |> put_private(:phoenix_action, :create)
        |> Map.put(:params, %{"date" => "2019-11-11", "number" => 100})
        |> ParamsValidatorPlug.validate_params(with: TestParams, action: :update)

      refute new_conn.halted
      assert new_conn.assigns[:validated_params] == nil
    end
  end
end
