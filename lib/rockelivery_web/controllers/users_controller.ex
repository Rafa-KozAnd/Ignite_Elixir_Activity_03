defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller
  alias Rockelivery.User
  alias RockeliveryWeb.FallbackController
  alias RockeliveryWeb.Auth.Guardian

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Rockelivery.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:created)
      |> render("sign_in.json", token: token)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _user} <- Rockelivery.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, user} <- Rockelivery.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end
end
