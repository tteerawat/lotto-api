defmodule LottoAPI.Guardian do
  use Guardian, otp_app: :lotto_api

  alias LottoAPI.{User, Users}

  @access_token_ttl {7, :days}

  @impl true
  def subject_for_token(%User{uid: uid}, _claims), do: {:ok, uid}
  def subject_for_token(_, _), do: {:errro, :resource_not_supported}

  @impl true
  def resource_from_claims(claims) do
    Users.fetch_user_by(uid: claims["sub"])
  end

  def generate_access_token(resource) do
    {:ok, token, _} = encode_and_sign(resource, %{}, ttl: @access_token_ttl, token_type: "access")
    token
  end
end
