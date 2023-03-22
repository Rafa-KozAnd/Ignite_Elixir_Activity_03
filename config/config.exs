# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :rockelivery,
  ecto_repos: [Rockelivery.Repo]

config :rockelivery, Rockelivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :rockelivery, Rockelivery.Users.Create, via_cep_adapter: Rockelivery.ViaCep.Client

# Configures the endpoint
config :rockelivery, RockeliveryWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: RockeliveryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rockelivery.PubSub,
  live_view: [signing_salt: "2TdL/9yV"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :rockelivery, Rockelivery.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

# Guardian
# <- Deve ser o nome do módulo em que estamos configurando
config :rockelivery, RockeliveryWeb.Auth.Guardian,
  Issuer: "rockelivery",
  secret_key: "5smx4j54Oqhcg8O4XfGmv05DRaHS5NYCx3iICr6FihENz9z7fUQDBYSB4hzHhHvD"

# Guardian Pipelines
# :rockelivery -> nome da aplicação, nome do módulo do Pipeline
config :rockelivery, RockeliveryWeb.Auth.Pipeline,
  # nome do módulo do Guardian na sua aplicação
  module: RockeliveryWeb.Auth.Guardian,
  # Nome do módulo de error handler 
  error_handler: RockeliveryWeb.Auth.ErrorHandler
