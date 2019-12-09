defmodule LottoAPIWeb.TokenController do
  use LottoAPIWeb, :controller

  alias LottoAPI.{Guardian, Users}

  plug :validate_params, with: LottoAPIWeb.CreateTokenParams, action: :create

  def create(conn, _) do
    %{email: email, password: password} = conn.assigns.validated_params

    case authenticate_user_by_email_and_password(email, password) do
      {:ok, user} ->
        access_token = Guardian.generate_access_token(user)

        conn
        |> put_status(:created)
        |> json(%{access_token: access_token})

      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(LottoAPIWeb.ErrorView)
        |> render("401.json")
    end
  end

  defp authenticate_user_by_email_and_password(email, password) do
    with {:ok, user} <- Users.fetch_user_by(email: email),
         true <- Argon2.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :not_found} ->
        Argon2.no_user_verify()
        {:error, :unauthorized}

      false ->
        {:error, :unauthorized}
    end
  end
end
