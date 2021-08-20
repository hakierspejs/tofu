defmodule Tofu.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    server_config = Tofu.Config.Server.read()

    children = [
      # HTTP server for webhooks
      {
        Plug.Cowboy,
        scheme: :http,
        plug:
          {Tofu.Server,
           %{
             :name => "ELO",
             :channel => "##wiadro"
           }},
        options: [port: server_config.port]
      },
      Tofu.Bot.Supervisor,

      # Key/Value store for Tofu application
      {CubDB, [data_dir: "./db/", name: Tofu.DB]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tofu.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
