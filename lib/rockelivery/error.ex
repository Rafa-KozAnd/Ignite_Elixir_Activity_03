defmodule Rockelivery.Error do
  @moduledoc """
    Módulo que faz o build das mensagens de erro da API
  """
  import Logger, only: [debug: 1]
  alias Ecto.Changeset
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, %Changeset{} = result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  # def build(status, result) when is_bitstring(result) do
  def build(status, result) do
    debug("#{status} |> #{result}")

    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_user_not_found_error do
    build(:not_found, "User not found")
  end

  def build_id_format_error(id \\ "undefined") do
    build(:bad_request, "Invalid ID: #{id} format")
  end
end
