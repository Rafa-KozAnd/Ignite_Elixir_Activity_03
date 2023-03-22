defmodule Rockelivery.Users.Delete do
  @moduledoc """
    Módulo de Usuários - Delete
  """
  alias Ecto.Changeset
  alias Rockelivery.{Error, Repo, User}

  import Logger, only: [debug: 1]

  @doc """
    Função que exclui um usuário através do seu UUID.
  """
  def call(id) do
    with %User{} = user <- Repo.get(User, id),
         {:ok, user} = result <- Repo.delete(user) do
      debug("Usuário #{user.id} excluído com sucesso!")
      result
    else
      nil ->
        {:error, Error.build_user_not_found_error()}

      {:error, %Changeset{}} ->
        {:error, Error.build(:internal_server_error, "Error trying delete user.")}
    end
  end
end
