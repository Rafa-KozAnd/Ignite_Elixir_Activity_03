defmodule Rockelivery.Users.Get do
  @moduledoc """
  Módulo de Usuários - Get
  """
  alias Rockelivery.{Error, Repo, User}

  @doc """
    Função que recupera um usuário através do seu UUID.
  """
  def by_id(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end
end
