defmodule LottoAPIWeb.Router do
  use LottoAPIWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LottoAPIWeb do
    pipe_through :api

    post "/admin/order-configs", OrderConfigurationController, :create
    get "/order-configs", OrderConfigurationController, :index
    resources "/orders", OrderTransactionController, only: [:index, :create]

    post "/tokens", TokenController, :create
  end

  scope "/" do
    pipe_through [:fetch_session, :protect_from_forgery]
    live_dashboard "/dashboard", metrics: LottoAPIWeb.Telemetry
  end
end
