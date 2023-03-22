defmodule Rockelivery.Users.Update do
  @moduledoc """
  Módulo de atualização de usuários
  """
  alias Ecto.Changeset
  alias Rockelivery.{Error, Repo, User}

  import Logger, only: [debug: 1]

  @doc """
    Função que atualiza um usuário com seus parâmetros.
  """
  def call(params) do
    case update(params) do
      {:ok, %User{}} = result ->
        result

      nil ->
        {:error, Error.build_user_not_found_error()}

      {:error, %Changeset{} = changeset} ->
        {:error, Error.build(:bad_request, changeset)}
    end
  end

  defp update(%{"id" => id} = params) do
    with %User{} = user <- Repo.get(User, id),
         {:ok, _user} = result <-
           user
           |> User.changeset(params)
           |> Repo.update() do
      debug("Usuário atualizado com sucesso.")
      result
    end
  end
end
