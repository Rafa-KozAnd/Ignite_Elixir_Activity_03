defmodule Rockelivery.ViaCep.Behaviour do
  @moduledoc """
    Beharviour para a validação de CPF. Declara a função get_cep_info que recebe a string do cep e retorna um map com os dados
  """
  alias Rockelivery.Error
  @callback get_cep_info(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
