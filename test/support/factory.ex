defmodule Rockelivery.Factory do
  @moduledoc """
    Factory para os testes do sistema
  """
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "address" => "Rua Atiriba",
      "age" => 22,
      "cep" => "21220520",
      "cpf" => "12345678901",
      "name" => "Leandro",
      "password" => "123456",
      "email" => "leandro.pnto@gmail.com"
    }
  end

  def user_factory do
    %User{
      address: "Rua Atiriba",
      age: 22,
      cep: "21220520",
      cpf: "12345678901",
      name: "Leandro",
      email: "leandro.pnto@gmail.com",
      password: "123456",
      id: "261d88dc-a284-4c64-b353-003f821c2353"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Irajá",
      "cep" => "21220-520",
      "complemento" => "",
      "ddd" => "21",
      "gia" => "",
      "ibge" => "3304557",
      "localidade" => "Rio de Janeiro",
      "logradouro" => "Rua Atiriba",
      "siafi" => "6001",
      "uf" => "RJ"
    }
  end
end
