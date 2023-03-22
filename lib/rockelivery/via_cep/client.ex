defmodule Rockelivery.ViaCep.Client do
  @moduledoc """
    Módulo cliente para a consulta de CEP

  """
  use Tesla
  plug Tesla.Middleware.JSON
  @base_url "https://viacep.com.br/ws/"

  alias Tesla.Env
  alias Rockelivery.Error
  alias Rockelivery.ViaCep.Behaviour

  @behaviour Behaviour

  def get_cep_info(url \\ @base_url, cep) do
    "#{url}/#{cep}/json"
    |> get()
    |> handle_get()
  end

  # defp handle_get({:ok, %Env{status: 404, body: %{"erro" => true}}}) do
  defp handle_get({:ok, %Env{status: 404}}) do
    {:error, Error.build(:not_found, "CEP not found!")}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 400, body: _body}}) do
    {:error, Error.build(:bad_request, "Invalid CEP")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
