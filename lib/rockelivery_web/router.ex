defmodule RockeliveryWeb.Router do
  use RockeliveryWeb, :router

  alias RockeliveryWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  # :auth é o nome do pipeline
  pipeline :auth do
    # Plugamos o pipeline de auth ao pipeline :auth 
    plug RockeliveryWeb.Auth.Pipeline
  end

  scope "/api", RockeliveryWeb do
    pipe_through :api

    get "/", WelcomeController, :index
    post "/users/signin", UsersController, :sign_in
    post "/users/create", UsersController, :create
  end

  scope "/api", RockeliveryWeb do
    pipe_through [:api, :auth]

    # Removemos a action de create do resources, para adicioná-la no escopo liberado.
    resources("/users", UsersController, except: [:new, :edit, :create])

    post "/items", ItemsController, :create

    post "/orders", OrdersController, :create
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RockeliveryWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
