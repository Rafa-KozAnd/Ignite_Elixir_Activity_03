defmodule RockeliveryWeb.UserControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.ViaCep.ClientMock
  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "When all parameters are correct, then create the user", %{conn: conn} do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep -> {:ok, build(:cep_info)} end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "timestamp" => _time,
               "user" => %{
                 "age" => 22,
                 "cep" => "21220520",
                 "cpf" => "12345678901",
                 "email" => "leandro.pnto@gmail.com",
                 "id" => _id,
                 "name" => "Leandro"
               }
             } = response
    end

    test "When there are some errors, return the error", %{conn: conn} do
      params = %{
        "password" => "123456",
        "name" => "Leandro"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "address" => ["can't be blank"],
                 "age" => ["can't be blank"],
                 "cep" => ["can't be blank"],
                 "cpf" => ["can't be blank"],
                 "email" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "261d88dc-a284-4c64-b353-003f821c2353"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert "" == response
    end
  end
end
