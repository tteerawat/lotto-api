defmodule LottoAPIWeb.Router do
  use LottoAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LottoAPIWeb do
    pipe_through :api

    post "/admin/order-configs", OrderConfigurationController, :create
    get "/order-configs", OrderConfigurationController, :index
  end
end
