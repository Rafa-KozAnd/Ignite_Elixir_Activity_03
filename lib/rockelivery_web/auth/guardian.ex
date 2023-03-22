defmodule RockeliveryWeb.Auth.Guardian do
  @moduledoc """
    Configuração do Guardian
  """
  use Guardian, otp_app: :rockelivery

  alias Rockelivery.User
  alias Rockelivery.Users.Get, as: UserGet
  alias Rockelivery.Error

  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    UserGet.by_id(id)
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
