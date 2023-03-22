defmodule Rockelivery.Orders.Report do
  @moduledoc """
    Módulo para geração de relatórios
  """
  import Ecto.Query
  alias Rockelivery.{Repo, Order}
  alias Rockelivery.Item
  alias Rockelivery.Orders.TotalPrice

  @default_block_size 500

  def create(filename \\ "report.csv") do
    query = from order in Order, order_by: order.user_id

    {:ok, order_list} =
      Repo.transaction(fn ->
        query
        |> Repo.stream(max_rows: @default_block_size)
        |> Stream.chunk_every(@default_block_size)
        |> Stream.flat_map(fn chunck -> Repo.preload(chunck, :items) end)
        |> Enum.map(&parse_line/1)
      end)

    File.write(filename, order_list)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    items_string = Enum.map(items, &item_string/1)
    "#{user_id},#{payment_method},#{items_string}#{TotalPrice.calculate(items)}\n"
  end

  defp item_string(%Item{category: category, description: description, price: price}) do
    "#{category},#{description},#{price},"
  end
end
