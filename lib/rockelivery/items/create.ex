defmodule Rockelivery.Items.Create do
  @moduledoc """
    Módulo de Items - Create
  """
  alias Rockelivery.{Error, Repo, Item}

  @doc """
    Função responsável pela criação do usuário na base de dados.
    Recebe os parâmetros para a criação.
  """
  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Item{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
