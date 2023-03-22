defmodule Rockelivery do
  @moduledoc """
  Rockelivery keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Rockelivery.Items.Create, as: ItemCreate
  alias Rockelivery.Orders.Create, as: OrderCreate
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Delete, as: UserDelete
  alias Rockelivery.Users.Get, as: UserGet
  alias Rockelivery.Users.Update, as: UserUpdate

  @doc """
  Função para criar um item no banco.
  """

  defdelegate create_item(params), to: ItemCreate, as: :call

  @doc """
    Função para criar um novo usuário. Receber um mapa com os parâmetros para criação.
  """
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate update_user(params), to: UserUpdate, as: :call

  defdelegate create_order(params), to: OrderCreate, as: :call
end
