defmodule RockeliveryWeb.OrdersView do
  use RockeliveryWeb, :view
  alias Rockelivery.Order

  def render("create.json", %{order: %Order{} = order}) do
    %{
      message: "Order created!",
      order: order,
      timestamp: NaiveDateTime.local_now()
    }
  end
end
