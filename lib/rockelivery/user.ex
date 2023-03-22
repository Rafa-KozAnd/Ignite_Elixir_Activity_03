defmodule Rockelivery.User do
  @moduledoc """
    Módulo de usuário.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @fields [:age, :address, :cep, :cpf, :email, :name, :password]
  @required_params [:age, :address, :cep, :cpf, :email, :name]
  @derive {Jason.Encoder, only: [:id, :age, :name, :cpf, :email, :cep]}

  schema("users") do
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def build(changeset), do: apply_action(changeset, :create)

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@required_params)
    |> validate_password(params)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
  end

  def validate_password(changeset, params) do
    updating? = Map.has_key?(params, "id")
    password? = Map.has_key?(params, "password")

    cond do
      password? ->
        changeset
        |> validate_required([:password])
        |> validate_length(:password, min: 6)
        |> put_password_hash()

      !password? && !updating? ->
        changeset
        |> validate_required([:password])

      true ->
        changeset
    end
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(%Changeset{} = changeset), do: changeset
end
