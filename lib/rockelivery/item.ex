defmodule Rockelivery.Item do
  @moduledoc """
    Módulo de items
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Rockelivery.Order
  @primary_key {:id, :binary_id, autogenerate: true}
  @fields [:category, :description, :price, :photo]
  @required_params [:category, :description, :price, :photo]
  @derive {Jason.Encoder, only: @required_params ++ [:id]}
  @items_categories [:food, :drink, :dessert]

  schema("items") do
    field :category, Ecto.Enum, values: @items_categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end
