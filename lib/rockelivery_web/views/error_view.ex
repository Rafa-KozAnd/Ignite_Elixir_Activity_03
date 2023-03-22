defmodule RockeliveryWeb.ErrorView do
  use RockeliveryWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]
  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    #  Phoenix.Controller.status_message_from_template(template)
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{result: %Changeset{} = result}) do
    %{message: translate_errors(result)}
  end

  def render("error.json", %{result: result}) do
    %{message: result}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", translate_value(value))
      end)
    end)
  end

  defp translate_value({:parameterized, Ecto.Enum, _map}), do: ""
  defp translate_value(value), do: to_string(value)
end
