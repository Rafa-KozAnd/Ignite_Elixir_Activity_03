defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view
  alias Rockelivery.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      message: "User created!",
      user: user,
      token: token,
      timestamp: NaiveDateTime.local_now()
    }
  end

  def render("sign_in.json", %{token: token}), do: %{token: token}

  def render("show.json", %{user: %User{} = user}), do: %{user: user}
end
