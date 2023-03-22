defmodule RockeliveryWeb.ItemsView do
  use RockeliveryWeb, :view
  alias Rockelivery.Item

  def render("create.json", %{item: %Item{} = item}) do
    %{
      message: "Item created!",
      item: item,
      timestamp: NaiveDateTime.local_now()
    }
  end
end
