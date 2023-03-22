defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true
  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "When all parameters are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)
      assert %Changeset{changes: %{name: "Leandro", cpf: "12345678901"}, valid?: true} = response
    end

    test "When updating a changeset, returns a valid changeset with given parameters" do
      params = build(:user_params)

      update_params = Map.put(params, "name", "Leandro Sávio")

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Leandro Sávio", cpf: "12345678901"}, valid?: true} =
               response
    end

    test "When there are some errors, returns a invalid changeset" do
      params = build(:user_params, %{"age" => 17, "password" => ""})

      response = User.changeset(params)

      assert %Changeset{valid?: false, errors: [age: _age, password: {"can't be blank", _}]} =
               response
    end
  end
end
