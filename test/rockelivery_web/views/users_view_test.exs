defmodule RockeliveryWeb.Views.UsersViewTest do
  use RockeliveryWeb.ConnCase
  use ExUnit.Case

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  describe "render" do
    test "renders create.json" do
      user = build(:user)
      token = "xpto12345"
      response = render(UsersView, "create.json", token: token, user: user)

      assert %{
               message: "User created!",
               timestamp: _time,
               token: "xpto12345",
               user: %Rockelivery.User{
                 address: "Rua Atiriba",
                 age: 22,
                 cep: "21220520",
                 cpf: "12345678901",
                 email: "leandro.pnto@gmail.com",
                 id: "261d88dc-a284-4c64-b353-003f821c2353",
                 inserted_at: nil,
                 name: "Leandro",
                 password: "123456",
                 password_hash: nil,
                 updated_at: nil
               }
             } = response
    end
  end
end
