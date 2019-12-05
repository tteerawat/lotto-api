defmodule LottoAPI.Repo do
  use Ecto.Repo,
    otp_app: :lotto_api,
    adapter: Ecto.Adapters.Postgres
end
