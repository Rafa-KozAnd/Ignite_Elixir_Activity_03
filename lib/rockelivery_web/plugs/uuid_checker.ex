defmodule RockeliveryWeb.Plugs.UUIDChecker do
  @moduledoc """
    Módulo para validar e adicionar o UUID recebido
  """
  import Plug.Conn
  alias Ecto.UUID
  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{params: %{"id" => id}} = conn, _opts) do
    case UUID.cast(id) do
      :error -> render_error(conn, id)
      {:ok, _uuid} -> conn
    end
  end

  def call(conn, _opts), do: conn

  defp render_error(conn, id) do
    body =
      Jason.encode!(%{
        message: "Invalid UUID: #{id}",
        timestamp: NaiveDateTime.local_now()
      })

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
