defmodule RockeliveryWeb.WelcomeController do
  use RockeliveryWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(200)
    |> text("Welcome to Rockelivery")
  end
end
