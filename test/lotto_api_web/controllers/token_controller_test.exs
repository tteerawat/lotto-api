defmodule LottoAPI.TokenControllerTest do
  use LottoAPIWeb.ConnCase

  describe "create/2" do
    test "renders 400 error response if the given params is invalid", %{conn: conn} do
      params = %{}

      conn = post(conn, Routes.token_path(conn, :create), params)

      assert json_response(conn, 400) == %{
               "errors" => %{
                 "email" => ["can't be blank"],
                 "password" => ["can't be blank"]
               }
             }
    end

    test "returns 401 error response if it is an unauthorized request", %{conn: conn} do
      params = %{"email" => "email", "password" => "password"}

      conn = post(conn, Routes.token_path(conn, :create), params)

      assert json_response(conn, 401) == %{"errors" => %{"detail" => "Unauthorized"}}
    end

    test "returns 204 created response if the given params is valid and it is an authorized request",
         %{conn: conn} do
      email = "test@gmail.com"
      password = "secret"
      params = %{"email" => email, "password" => password}
      LottoAPI.Users.create_user!(params)

      conn = post(conn, Routes.token_path(conn, :create), params)

      assert %{"access_token" => access_token} = json_response(conn, 201)
      assert is_binary(access_token)
    end
  end
end
