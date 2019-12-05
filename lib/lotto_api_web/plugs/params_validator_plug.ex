defmodule LottoAPIWeb.ParamsValidatorPlug do
  import Phoenix.Controller, only: [put_view: 2, render: 3]
  import Plug.Conn

  alias Ecto.Changeset
  alias LottoAPIWeb.ErrorView

  def validate_params(%{private: %{phoenix_action: phoenix_action}} = conn,
        with: params_module,
        action: action
      )
      when phoenix_action == action do
    changeset = params_module.changeset(conn.params)

    if changeset.valid? do
      assign(conn, :validated_params, extract_changes(changeset))
    else
      conn
      |> halt()
      |> put_status(:bad_request)
      |> put_view(ErrorView)
      |> render("error.json", changeset: changeset)
    end
  end

  def validate_params(conn, _) do
    conn
  end

  defp extract_changes(%Changeset{} = changeset) do
    Enum.reduce(changeset.changes, %{}, fn {key, value}, params ->
      Map.put(params, key, extract_changes(value))
    end)
  end

  defp extract_changes([%Changeset{} | _] = changesets) do
    Enum.map(changesets, &extract_changes/1)
  end

  defp extract_changes(value) do
    value
  end
end
