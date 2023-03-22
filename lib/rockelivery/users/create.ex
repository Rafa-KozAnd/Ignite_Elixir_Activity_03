defmodule Rockelivery.Users.Create do
  @moduledoc """
    Módulo de usuários - Create
  """
  alias Rockelivery.{Error, Repo, User}

  @doc """
    Função responsável pela criação do usuário na base de dados.
    Recebe os parâmetros para a criação.
  """
  def call(params) do
    cep = Map.get(params, "cep")
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, _cep_info} <- client().get_cep_info(cep),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp client do
    Application.fetch_env!(:rockelivery, __MODULE__)[:via_cep_adapter]
  end
end
