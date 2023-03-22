defmodule Rockelivery.Orders.Create do
  @moduledoc """
    Módulo para a criação de Ordens

  """
  alias Rockelivery.{Error, Item, Order, Repo}
  alias Rockelivery.Orders.ValidateAndMultiplyItems

  import Ecto.Query

  @doc """
    Função responsável pela criação do ordens na base de dados.
    Recebe os parâmetros para a criação.
  """
  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  def fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)
    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(items_ids, items_params)
  end

  defp handle_items({:error, result}, _params), do: Error.build(:bad_request, result)

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = order), do: order

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
