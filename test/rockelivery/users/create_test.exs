defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.ViaCep.ClientMock

  describe "call/1" do
    test "When all parameters are valid, then create the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep -> {:ok, build(:cep_info)} end)

      response = UserCreate.call(params)
      assert {:ok, %User{id: _id, age: 22, email: "leandro.pnto@gmail.com"}} = response
    end

    test "When there are invalid parameters, then returns an error" do
      params = build(:user_params, %{"password" => "123", "age" => 15})

      response = UserCreate.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
