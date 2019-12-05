defmodule LottoAPIWeb.Router do
  use LottoAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LottoAPIWeb do
    pipe_through :api
  end
end
